//=============================date & time======================================
//https://www.w3schools.com/js/js_date_methods.asp
//Date(year, month, day, hours, minutes, seconds, milliseconds)
// ex. new Date(2018, 11, 24, 10, 33, 30, 0);
//(날짜만)dt.toDateString();
//(시간)dt.toISOString();// dt.toString();//dt.toUTCString();

/*var dt = new Date();
var months = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"];
var days = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"];

yy = dt.getFullYear();
mm = months[dt.getMonth()];
dd = dt.getDate();

day = days[dt.getDay()];

h = dt.getHours();
m = dt.getMinutes();
s = dt.getSeconds();

var dtText = day + ", " + mm + " " + dd + ", " + yy + " " + h + ":" + m + ":" + s
*/


function get_datetime(){
  var dt = new Date();
  document.getElementById("datetime").innerHTML = dt.toString();//dt.toUTCString();//dtText;
}