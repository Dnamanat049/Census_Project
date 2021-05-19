//H0110004: rent occupied
//* = wildcard (matches anything)
//query: https://api.census.gov/data/2010/sf1?key=e8a63d6bac96233cd5c3cf2de348ed9882285b0a&get=H0110004,NAME&for=state:*

String [] states2000 = new String[51];
String [] states2010 = new String[51];
String [] states = new String[51];
int [] inhabitants2010 = new int [51];
int [] inhabitants2000 = new int [51];
float avg2010;
float avg2000;
float sf = 50000; //scale factor
PrintWriter output;
PrintWriter bigOutput;
int counter = 0;
float difference = 0;
float realPercent = 0;

void setup() {
  JSONArray json2000;
  JSONArray json2010;
  String [] states = loadStrings("State_Names.txt");
  json2000 = loadJSONArray("Census_2000.json");
  json2010 = loadJSONArray("Census_2010.json"); 
  //Loads all the necessary information
 
  bigOutput = createWriter("index.html");  //Creates the homepage
    bigOutput.println("<html><head>");
    bigOutput.println("<title>Change in White Population from 2000 to 2010</title>");
    bigOutput.println("<link href='style.css' rel='stylesheet' type='text/css'><link href='https://fonts.googleapis.com/css?family=Slabo+27px' rel='stylesheet'>");
    bigOutput.println("</head><body>");
    bigOutput.println("<h1>A Sense (of) US</h1>");
    bigOutput.println("<h2>Did the U.S. become more diverse between 2000 and 2010?</h2>");
    bigOutput.println("<center><img src='USA_Map.png' alt='COLORED USA MAP'></center>");
    bigOutput.println("<center><svg width='800' height='50' xmlns='http://www.w3.org/2000/svg'>");
    for (int x = 1; x < 6; x++) {
      bigOutput.println("<rect x = "+ (300+(20*x)) +" y = 0 width = '20' height = 50 style='fill:rgb(255, " + (40*x) + ", 0)' />");
    }
    bigOutput.println("<text x='175' y = 30 fill='rgb(144, 12, 63)' font-size='14'>9% increase in diversity</text>");
    bigOutput.println("<text x='434' y = 30 fill='rgb(144, 12, 63)' font-size='14'>12% decrease  in diversity</text>");
    bigOutput.println("</svg></center>");
    bigOutput.println("<center><p></p><p>I looked at the population of white Americans to see whether it increased or decreased between 2000 and 2010, and I found the percentage change for each state.</p>");
    bigOutput.println("<p>Then I found the average U.S. population increase for each individual state during that time period, which was 9.7%.</p>");
    bigOutput.println("<p>Next, I compared the two to see if the population increase (%) in the U.S. as a whole outpaced the increase (%) in the white population for each state. Based off of that information, I was able to reasonably predict whether a state had become more diverse over that period of time.</p>");
    bigOutput.println("<p>Nationally, the average percentage increase in the white population was 6.67%, so as a whole the U.S. did become more diverse!</p>");
    bigOutput.println("<p>Since the national population increase was not specific to each state, I included the word 'likely' in each of the state pages to indicate that the number is true relative to the U.S. population as a whole, but not necessarily that specific state (A.K.A. numbers for large states, such as New York, may be skewed).</p> </center>");
    bigOutput.println("<table>");
    for (int r = 0; r < 12; r++) {
      bigOutput.println("<tr>");
      for (int i = 0; i < 4; i ++) {
        bigOutput.println("<td><a href = 'website/" + json2000.getJSONArray(counter).getString(1) + ".html'>" + json2000.getJSONArray(counter).getString(1) + "</a></td>");
        counter++;
       }
      bigOutput.println("</tr>");
     }
    bigOutput.println("<tr><td></td><td><a href = 'website/" + json2000.getJSONArray(49).getString(1) + ".html'>" + json2000.getJSONArray(49).getString(1) + "</a></td><td><a href = 'website/" + json2000.getJSONArray(50).getString(1) + ".html'>" + json2000.getJSONArray(50).getString(1) + "</a></td></tr>");
    bigOutput.println("</table>");
    bigOutput.println("</body></html>");
    bigOutput.flush(); // Writes the remaining data to the file
    bigOutput.close(); // Finishes the file
  
  
  
  for (int i = 0; i < 51; i ++) { //All this does is create avg2000
    states2000[i] = json2000.getJSONArray(i).getString(1);
    inhabitants2000[i] = json2000.getJSONArray(i).getInt(0);
  avg2000 += inhabitants2000[i];
  }
  avg2000 = avg2000 / states2000.length;
  println(avg2000);
  
  for (int i = 0; i < 51; i ++) { //All this does is create avg2000
    states2010[i] = json2010.getJSONArray(i).getString(1);
    inhabitants2010[i] = json2010.getJSONArray(i).getInt(0);
  avg2010 += inhabitants2010[i];
  }
  avg2010 = avg2010 / states2010.length;
  println(avg2010);
  
  
  for(int i = 0; i<states.length; i++){
    String state = states[i];
    println(state);
    int population2000 = json2000.getJSONArray(i).getInt(0);
    int population2010 = json2010.getJSONArray(i).getInt(0);
    difference = population2010-population2000;
    realPercent = abs(difference/population2010);
    
    float cool = 0;
    float interesting = 0;
    cool = avg2010-avg2000;
    interesting = abs(cool/avg2010);
    println(100*interesting);
    
    
    output = createWriter("website/"+json2000.getJSONArray(i).getString(1)+".html"); 
    output.println("<html><head>");
    output.println("<title>" + states[i] + "</title>");
    output.println("<link href='../style.css' rel='stylesheet' type='text/css'><link href='https://fonts.googleapis.com/css?family=Slabo+27px' rel='stylesheet'>");
    output.println("</head><body>");
    output.println("<h1><a href = 'https://en.wikipedia.org/wiki/" + states[i] + "'>" + json2000.getJSONArray(i).getString(1) + "</a></h1>");
    output.println("<h2>Did the U.S. become more diverse between 2000 and 2010?</h2>");
    output.println("<p>Key: Dark Orange is the national average, and light yellow is the state average</p>");
    //Make the svg
    output.println("<center><svg width='500' height='220' xmlns='http://www.w3.org/2000/svg'>");
    output.println("<rect x = 60 y = " + (195 - (population2000/sf)) + " width = '80' height = " + (population2000/sf) + " style='fill:rgb(255, 195, 0)' />");
    output.println("<text x='60' y='"+ (187 - (population2000/sf)) + "' fill='rgb(144, 12, 63)' font-size='14'>"+round(population2000/10000)+" (2000)</text>");
    output.println("<rect x = 160 y = '" + (195 - (avg2000/sf)) + "' width = 80 height = " + (avg2000/sf) + " style='fill:rgb(255, 87, 51)'/>");
    output.println("<text x='160' y='"+ (187 - (avg2000/sf)) + "' fill='rgb(144, 12, 63)' font-size='14'>"+round(avg2000/10000)+" (2000)</text>");
    output.println("<rect x = 260 y = '" + (195 - (population2010/sf)) + "' width = 80 height = " + (population2010/sf) + " style='fill:rgb(255, 195, 0)' />");
    output.println("<text x='260' y='"+ (187 - (population2010/sf)) + "' fill='rgb(144, 12, 63)' font-size='14'>"+round(population2010/10000)+" (2010)</text>");
    output.println("<rect x = 360 y = '" + (195 - (avg2010/sf)) + "' width = 80 height = " + (avg2010/sf) + " style='fill:rgb(255, 87, 51)' />");
    output.println("<text x='360' y='"+ (187 - (avg2010/sf)) + "' fill='rgb(144, 12, 63)' font-size='14'>"+round(avg2010/10000)+" (2010)</text>");
    output.println("<line x1 = '0' y1 = '196' x2 = '500' y2 = '196' style='stroke:rgb(255,255,255); stroke-width:4'/>");
    output.println("<text x='175' y='215' fill='rgb(144, 12, 63)' font-size='14'>WHITE Population (In 10,000's)</text>");
    output.println("</svg></center>");
    
    
    
    //compare state average to national average in 2000
    output.println("<center><p>" + json2000.getJSONArray(i).getString(1) + " had a ");
    if ((population2000) > (population2010)) {
      output.println("" + (100*realPercent) + "% decrease in WHITE inhabitants between 2000 and 2010. This was ");
    } else {
      output.println("" + (100*realPercent) + "% increase in WHITE inhabitants between 2000 and 2010. This was ");
    }
    
    //compare state average to national average in 2010
    if ((100*realPercent) > 9.7) {
      output.println("greater than the national increase in population of ALL RACES of 9.7%, which means that " + json2000.getJSONArray(i).getString(1) + " likely became less diverse. </p>");
    } else {
      output.println("less than the national increase in population of ALL RACES of 9.7%, which means that " + json2000.getJSONArray(i).getString(1) + " likely became more diverse! </p>");
    }
    
    output.println("<p> The state had " + population2000 + " white inhabitants in 2000 and had " + population2010 + " white inhabitants in 2010. </p>");
    
    
    
    //Link to other pages
    output.println("<p></p> <a href = 'https://www.census.gov/data/developers/data-sets/decennial-census.2010.html'>Census Link</a>");
    if (i == 0) {
      output.println("<p></p> <a href = '" + states[50] + ".html'>Back</a>");
      output.println("<p></p> <a href = '" + states[1] + ".html'>Next</a>");
    } else if (i == 50) {
      output.println("<p></p> <a href = '" + states[49] + ".html'>Back</a>");
      output.println("<p></p> <a href = '" + states[0] + ".html'>Next</a>");
    } else {
      output.println("<p></p> <a href = '" + states[i-1] + ".html'>Back</a>");
      output.println("<p></p> <a href = '" + states[i+1] + ".html'>Next</a>");
    }
    output.println("<p></p> <a href = '../index.html'>Home page</a>");
    output.println("</body></html>");
    output.flush(); // Writes the remaining data to the file
    output.close(); // Finishes the file
    println("Done");
    println(states.length);
  }
}