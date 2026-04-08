rates ={
    'Economy':10,
    'Premium':18,
    'SUV':25
}

def get_time_label(hour):
    if 5<= hour<12:
        return "Morning"
    elif 12<=hour<17:
        return "Afternoon"
    elif 17<=hour<=20:
        return "Evening(Peak Hours)"
    else:
        return "Night"

def calculate_fare(km,vehicle_type,hour):
    if vehicle_type not in rates:
        return None

    rate = rates[vehicle_type]
    base_fare=km*rate
    surge_applied=17<=hour<=20
    final_fare =base_fare* 1.5 if surge_applied else base_fare
    return{
        'vehicle': vehicle_type,
        'km': km,
        'rate': rate,
        'base_fare': base_fare,
        'surge_applied': surge_applied,
        'final_fare': final_fare,
        'time_label': get_time_label(hour)
    }

def print_receipt(info):
    print("Welcome to FareIdea")
    print("Tge Best there Ever Will Be")
    print(f"Vehicle : {info['vehicle']}")
    print(f"Distance : {info['km']} km")
    print(f"Rate: Rs.{info['rate']} per km")
    print(f"Time Slot : {info['time_label']}")
    print(f"Base Fare : Rs.{info['base_fare']:.2f}")
    if info['surge_applied']:
        print(f"Surge: 1.5x (Peak hours 5PM - 8PM)")
    print(f"Total: Rs.{info['final_fare']:.2f}")
    print("Thank You")

def main():
    print("Fare Estimator\n")
    print(f"Available vehicles: {', '.join(rates.keys())}")
    print(f"Rates per km  : { {k: 'Rs.'+str(v) for k, v in rates.items()} }\n")

    try:
        km = float(input("Enter distance (km): "))
        if km <= 0:
            print("Distance must be greater than 0.")
            return
    except ValueError:
        print("Invalid input for distance.")
        return
    vehicle = input("Enter vehicle type: ").strip().title()
    if vehicle not in rates:
        print(f"Service Not Available. '{vehicle}' is not offered.")
        print(f"Please choose from: {', '.join(rates.keys())}")
        return
    try:
        hour = int(input("Enter current hour (0-23): "))
        if not (0 <= hour <= 23):
            print("Hour must be between 0 and 23.")
            return
    except ValueError:
        print("Invalid input for hour.")
        return

    result = calculate_fare(km, vehicle, hour)
    print_receipt(result)

if __name__ == "__main__":
    main()
