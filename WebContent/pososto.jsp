<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>

<%@ page import="java.io.*, java.net.*"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>SkrinouMichaela</title>
<link rel="stylesheet" href="main.css" type="text/css" />
<script src="jquery-3.1.1.min.js"></script>
<script src="https://canvasjs.com/assets/script/jquery.canvasjs.min.js"></script>

</head>
<body>
	<h1>Covid Vaccination</h1>
	<div id="container">
		<div id="header">
			<p style="text-align:center;"><img src="photo.jpg" alt="Logo"></p>
			<ul id="nav">
				<li><a href="index.jsp">Vaccination per Day</a></li>
				<li><a href="newPage.jsp">Total Vaccinated People </a></li>
				<li><a href="pososto.jsp">Total Distinct People Rate </a></li>
			</ul>
		</div>
	</div>

	<h2>Total Disticnt People Rate</h2>	
	<div class="container">
	<div class="row">
	
	<table class="table" id="data">
		<thead>
			<tr>
				<th>Date</th>
				<th>Total Vaccinated Persons</th>
				<th>Total Vaccinations</th>
				<th>Rate of Total Vaccinated</th>
			</tr>
		</thead>
		<tbody>
		</tbody>
	</table>
	</div> </div>
	<script>
		function findIndex(data, referencedate) {
			for (var i = 0; i < data.length; i++) {
				if (data[i].referencedate == referencedate) {
					return i;
				}
			}

			return -1;
		}

		$(document).ready(function(){
			
		    $.ajax({
			      url: 'FetchData',
			      success: function(data) {
			        let html = '';
			        
			        var result = [];
			        $.each(data, function(key, value){
			        	let idx = findIndex(result, value['referencedate']);
			        	
			        	if(idx == -1) {
			        		result.push({referencedate : value['referencedate'], 
				        		totaldose1: value['totaldose1'], 
				        		totaldose2: value['totaldose2'], 
				        		totaldistinctpersons: value['totaldistinctpersons'],
				        		totalvaccinations: value['totalvaccinations']})
			        	} else {
			        		result[idx].totaldose1 += value['totaldose1'];
			        	}
			        });
			        	
			        
			        //$.each(result, function(key, value){
			        	for(var i=0; i<result.length; i++) {
			        	let d = new Date(result[i].referencedate);
			         	
			        	let pososto = "NaN"; 
			        	if(i > 0) {
			        		pososto = (result[i].totaldistinctpersons / result[i].totalvaccinations)*100;
			        	}
			        	
			        	html += '<tr><td>' + d.toLocaleDateString() +
			        		'</td><td>' + result[i].totaldistinctpersons + 
			            	'</td><td>' + result[i].totalvaccinations + 
			            	'</td><td>' + pososto + 
							'</td></tr>';
			    	//});	
			        }
			        $('#data').append(html);
			      }
			    });
			
		});
	</script>
</body>
</html>