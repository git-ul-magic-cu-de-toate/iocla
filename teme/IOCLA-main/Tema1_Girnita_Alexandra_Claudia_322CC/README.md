TEMA 1 - IOCLA - To pit or not to pit... this is the strategy
Nume : Girnita Alexandra-Claudia
Grupa : 322CC


Implementarea consta in crearea unui vector de tip Sensor* ce contine doua tipuri de senzori: 
-> Tire Sensor
-> Power Management Unit Sensor 

Structuri
num sensor_type {
	TIRE,
	PMU
};

typedef struct {
	enum sensor_type sensor_type; 	// 0/1
	void *sensor_data; 		// TireSensor/PowerManagementUnit
	int nr_operations;
	int *operations_idxs;
} Sensor;

typedef struct __attribute__((__packed__)) {
    float voltage;  			// voltage level of the battery; 10-20 volts
    float current;  			// current draw from the battery; -100 to 100 amps; negative values indicate energy regeneration during braking
    float power_consumption;  		// power consumption of the car; 0 to 1000 kilowatts
    int energy_regen;  		        // energy regenerated during braking; between 0-100%
    int energy_storage;  		// amount of energy stored in the battery; between 0-100%
} PowerManagementUnit;

typedef struct __attribute__((__packed__)) {
	float pressure; 		// 19-26 psi
	float temperature; 		// between 0-120C 
	int wear_level; 		// interval between 0-100%;. 0% wear means new tire.
	int performace_score;		// between 1-10; 1 low performance; 10 high performance
} TireSensor;


Implementare
-> main : 
	  * se deschide fisierul binar folosind primul argument dat din linia de
comanda, apoi se citeste numarul de senzori care vor urma sa fie adaugati intr un
vector alocat dinamic
	  * dupa ce se aloca vectorul cu dimensiunea corespunzatoare, se insereaza
fiecare tip de senzor (tire sau pmu) in functie de prioritatea acestuia (daca este
de tip tire se adauga dupa cele pmu iar daca este de tip pmu se adauga la inceput)
	  * se citesc toate datele corespunzatoare si operatiile fiecarui senzor 
iar apoi se inchide fisierul binar
	  * urmeaza partea in care se citesc instructiuni de la tastatura pana cand
se primeste comanda exit

-> print: 
	  * se citeste si un index de la tastatura iar apoi se apeleaza functia
print care afiseaza in functie de tipul senzorului index detaliile acestuia
conform cerintei

-> analyze:
 	  * se aloca o structura void** iar apoi se apeleaza functia get_operations
care va salva intr un vector generic fiecare adresa a unei operatii void*
	  * in functie de numarul operatiei, se apeleaza functia corespunzatoare

-> clear:
	 * pentru fiecare senzor se verifica in functie de tipul acestuia daca
valorile sunt eronate, si in caz ca sunt, se dezaloca senzorul sters si apoi se
muta fiecare senzor dupa acesta cu o pozitie in stanga
	 * intr un final, se realoca vectorul cu dimensiunea actualizata

-> exit_func:
	* se dezaloca zona data si operation a fiecarui senzor, apoi se dezaloca
vectorul de senzori	
