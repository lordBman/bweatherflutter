const days =  ["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"];
String day(int value)=> days[value % 7];

const months = ["January", "Febrary", "Match", "April", "May", "June",  "July", "August", "September", "October", "November", "December"];
String month(int value) => months[value - 1];

int celciustToFahrenheit(double celcius) => (celcius * 1.8 + 32).ceil();