#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "structs.h"
#include "operations.h"

sensor *sensors;
int sensors_nr;

void print(int index)
{
	if (sensors[index].sensor_type) // senzor de tip PMU
	{
		power_management_unit *sensor = ((power_management_unit *)sensors[index].sensor_data);

		printf("Power Management Unit\n");
		printf("Voltage: %.2f\n", sensor->voltage);
		printf("Current: %.2f\n", sensor->current);
		printf("Power Consumption: %.2f\n", sensor->power_consumption);
		printf("Energy Regen: %d%%\n", sensor->energy_regen);
		printf("Energy Storage: %d%%\n", sensor->energy_storage);
	}
	else // senzor de tip Tire
	{
		tire_sensor *sensor = ((tire_sensor *)sensors[index].sensor_data);

		printf("Tire Sensor\n");
		printf("Pressure: %.2f\n", sensor->pressure);
		printf("Temperature: %.2f\n", sensor->temperature);
		printf("Wear Level: %d%%\n", sensor->wear_level);

		if (sensor->performace_score)
			printf("Performance Score: %d\n", sensor->performace_score);
		else
			printf("Performance Score: Not Calculated\n");
	}
}

void analyze(int index)
{
	void **operations = (void **)malloc(8 * sizeof(void *));
	get_operations(operations); // se copiaza operatiile in vector

	for (int i = 0; i < sensors[index].nr_operations; i++)
	{
		void (*fun_ptr)(void *) = operations[sensors[index].operations_idxs[i]]; // adresa functiei
		(*fun_ptr)(sensors[index].sensor_data);
	}

	free(operations); // se elibereaza vectorul
}

void clear()
{
	for (int i = 0; i < sensors_nr; i++)
	{
		int valid = 1;

		if (sensors[i].sensor_type) // senzor de tip PMU
		{
			power_management_unit *sensor = ((power_management_unit *)sensors[i].sensor_data);

			if (sensor->voltage < 10 || sensor->voltage > 20)
				valid = 0;

			if (sensor->current < -100 || sensor->current > 100)
				valid = 0;

			if (sensor->power_consumption < 0 || sensor->power_consumption > 1000)
				valid = 0;

			if (sensor->energy_regen < 0 || sensor->energy_regen > 100)
				valid = 0;

			if (sensor->energy_storage < 0 || sensor->energy_storage > 100)
				valid = 0;
		}
		else // senzor de tip Tire
		{
			tire_sensor *sensor = ((tire_sensor *)sensors[i].sensor_data);

			if (sensor->pressure < 19 || sensor->pressure > 28)
				valid = 0;

			if (sensor->temperature < 0 || sensor->temperature > 120)
				valid = 0;

			if (sensor->wear_level < 0 || sensor->wear_level > 100)
				valid = 0;
		}

		if (!valid) // senzorul contine valori eronate
		{
			// se elibereaza memoria senzorului
			free(sensors[i].sensor_data);

			if (sensors[i].operations_idxs != NULL)
				free(sensors[i].operations_idxs);

			// senzorul se elimina din vector
			memcpy(sensors + i, sensors + i + 1, (sensors_nr - i - 1) * sizeof(sensor));

			sensors_nr--;
			sensors = (sensor *)realloc(sensors, sensors_nr * sizeof(sensor));
			i--;
		}
	}
}

void exit_func()
{
	// eliberarea memoriei

	for (int i = 0; i < sensors_nr; i++)
	{
		free((tire_sensor *)sensors[i].sensor_data);

		if (sensors[i].operations_idxs != NULL)
			free(sensors[i].operations_idxs);
	}

	free(sensors);
}

int main(int argc, char const *argv[])
{
	char infile_name[100], command[30];
	int i, j, pmu_nr = 0, ts_nr = 0, sensor_type, index;

	strcpy(infile_name, argv[1]);
	FILE *input = fopen(infile_name, "rb");

	fread(&sensors_nr, sizeof(int), 1, input); // numar de senzori
	sensors = (sensor *)malloc(sensors_nr * sizeof(sensor));

	for (i = 0; i < sensors_nr; i++)
	{
		fread(&sensor_type, sizeof(int), 1, input); // tipul de senzor

		// senzorul se insereaza in vector la indexul calculat

		if (!sensor_type) // senzor de tip Tire
		{
			index = ts_nr + pmu_nr;
			ts_nr++;
		}
		else // senzor de tip PMU
		{
			memcpy(sensors + pmu_nr + 1, sensors + pmu_nr, ts_nr * sizeof(sensor));
			index = pmu_nr++;
		}

		// se completeaza structura

		sensors[index].sensor_type = sensor_type;

		if (sensors[index].sensor_type) // senzor de tip PMU
		{
			power_management_unit *sensor = (power_management_unit *)malloc(sizeof(power_management_unit));

			// datele senzorului PMU
			fread(&sensor->voltage, sizeof(float), 1, input);
			fread(&sensor->current, sizeof(float), 1, input);
			fread(&sensor->power_consumption, sizeof(float), 1, input);
			fread(&sensor->energy_regen, sizeof(int), 1, input);
			fread(&sensor->energy_storage, sizeof(int), 1, input);

			sensors[index].sensor_data = (void *)sensor;
		}
		else // senzor de tip Tire
		{
			tire_sensor *sensor = (tire_sensor *)malloc(sizeof(tire_sensor));

			// datele senzorului Tire
			fread(&sensor->pressure, sizeof(float), 1, input);
			fread(&sensor->temperature, sizeof(float), 1, input);
			fread(&sensor->wear_level, sizeof(int), 1, input);
			fread(&sensor->performace_score, sizeof(int), 1, input);

			sensors[index].sensor_data = (void *)sensor;
		}

		// numarul de operatii ce vor fi aplicate pe datelor senzorului
		fread(&sensors[index].nr_operations, sizeof(int), 1, input);
		sensors[index].operations_idxs = (int *)malloc(sensors[index].nr_operations * sizeof(int));

		// operatiile ce vor fi aplicate
		for (j = 0; j < sensors[index].nr_operations; j++)
			fread(&sensors[index].operations_idxs[j], sizeof(int), 1, input);
	}

	fclose(input);

	while (1)
	{
		scanf("%s", command);

		if (strcmp(command, "print") == 0) // comanda print
		{
			scanf("%d", &index);

			if (index < 0 || index > sensors_nr)
			{
				printf("Index not in range!\n");
				continue;
			}

			print(index);
		}

		if (strcmp(command, "analyze") == 0) // comanda analyze
		{
			int index;
			scanf("%d", &index);

			if (index < 0 || index > sensors_nr)
			{
				printf("Index not in range!\n");
				continue;
			}

			analyze(index);
		}

		if (strcmp(command, "clear") == 0) // comanda clear
			clear();

		if (strcmp(command, "exit") == 0) // comanda exit
		{
			exit_func();
			break; // se iese din program
		}
	}

	return 0;
}
