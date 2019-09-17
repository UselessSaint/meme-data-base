import random as r
import faker as f
import datetime

f = f.Faker()

def region_gen():
    pop = r.randint(10000, 10000000)
    name = f.city()

    return pop, name

def fact_gen():
    date = f.date()
    regid = r.randint(1,1000)

    return date, regid

def model_gen():
    tpe = r.choice(["C", "M", "P", "S", "U"])
    name = tpe + str(r.randint(1, 1000))

    return name, tpe

def client_gen():
    name = f.name()

    return name

def order_gen():
    client = r.randint(1, 1000)
    m_id = r.randint(1, 1000)
    dor = f.date_of_birth().strftime('%Y-%m-%d')

    cd = f.date_of_birth().strftime('%Y-%m-%d')

    aid = r.randint(100000, 50000000)

    return client, m_id, dor, cd, aid


def conection_gen():
    fst = r.randint(1, 1000)
    snd = r.randint(1, 1000)

    return fst, snd

def main():
    file = open("region_data.txt", "w")
    for i in range(1000):
        file.write('1 ; {} ; {}\n'.format(*region_gen()))
    file.close()

    file = open("factory_data.txt", "w")
    for i in range(1000):
        file.write('1 ; {} ; {}\n'.format(*fact_gen()))
    file.close()
    
    file = open("model_data.txt", "w")
    for i in range(1000):
        file.write('1 ; {} ; {}\n'.format(*model_gen()))
    file.close()

    file = open("client_data.txt", "w")
    for i in range(1000):
        file.write('1 ; {}\n'.format(client_gen()))
    file.close()

    file = open("order_data.txt", "w")
    for i in range(1000):
        file.write('1 ; {} ; {} ; {} ; {} ; {}\n'.format(*order_gen()))
    file.close()

    file = open("conection_data.txt", "w")
    for i in range(1000):
        file.write('{} ; {}\n'.format(*conection_gen()))
    file.close()
        

if __name__ == "__main__":
    main()
    
