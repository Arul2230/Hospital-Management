<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
            <link rel="stylesheet" type="text/css" href="static/css/Ward.css"/>

<link rel="stylesheet" href="https://unpkg.com/@coreui/coreui/dist/css/coreui.min.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
<link href="https://use.fontawesome.com/releases/v5.0.4/css/all.css" rel="stylesheet">
<style>
.foo {
  float: left;
  width: 140px;
  height: 120px;
  margin: 5px;
  border-radius : 10px;
  border: 1px solid rgba(0, 0, 0, .2);
}

.blue {
  background: #13b4ff;
}

.green {
  background: #66ff66;
}

.wine {
  background: #ffb413;
}
.red {
 background: #ff4d4d;

}
button{
    background: none;
    
    border: none;
    padding: 0;

}

<--TOAST-->
#snackbar {
    visibility: hidden;
    min-width: 250px;
    margin-left: -125px;
    background-color: #333;
    color: #fff;
    text-align: center;
    border-radius: 2px;
    padding: 16px;
    position: fixed;
    z-index: 1;
    left: 50%;
    bottom: 30px;
    font-size: 17px;
}

#snackbar.show {
    visibility: visible;
    -webkit-animation: fadein 0.5s, fadeout 0.5s 2.5s;
    animation: fadein 0.5s, fadeout 0.5s 2.5s;
}

@-webkit-keyframes fadein {
    from {bottom: 0; opacity: 0;} 
    to {bottom: 30px; opacity: 1;}
}

@keyframes fadein {
    from {bottom: 0; opacity: 0;}
    to {bottom: 30px; opacity: 1;}
}

@-webkit-keyframes fadeout {
    from {bottom: 30px; opacity: 1;} 
    to {bottom: 0; opacity: 0;}
}

@keyframes fadeout {
    from {bottom: 30px; opacity: 1;}
    to {bottom: 0; opacity: 0;}
}
<--TOAST-->
</style>
<html>
   <head>
      <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
      <title>Admin page</title>
   </head>
   <body>
      <jsp:include page="header.jsp"/>
      <div id="wrapper">
         <!-- Sidebar -->
         <div id="sidebar-wrapper">
            <ul class="sidebar-nav">
               <li class="sidebar-brand highlight">
                  <a href="index">
                  Home
                  </a>
               </li>
               <li>
                  <a href="DisplayAllWards">View Wards</a> 
               </li>
               <li>
                     <a href="nurseHome">Display In Patients</a>
               </li>
            </ul>
         </div>
         <!-- /#sidebar-wrapper -->
         <!-- Page Content -->
         
         <div id="page-content-wrapper">
         
            <div class="container-fluid">
               <div class="row">
               
                  <div class="col-lg-12">
                             
    <form action="searchWard" method="post" style="display: inline;">
                           <button>
                           <input type="hidden" value="${wardNumber}" name="wardNumber">
                                    
                        <button class="btn btn-success" type="submit" style="float:left">Back to Rooms</button><br>
                        </form>
                      <br><div style="width:1200px; height:600px;padding: 10px;border: 2px solid black;padding: 10px; border-radius: 25px; overflow: auto;"> 
                      
                      
                      <h1 style="text-align:center">Room : ${room.roomNumber}</h1><br>
                       <c:choose>
                        <c:when test="${admitButton == 'Yes'}">
                       
                                                 <div style="text-align:center;">
                      <c:forEach items="${room.beds}" var="bed">
                    <c:if test="${bed.status == 'Available'}">
                     <form action="admitPatient" method="post" style="display: inline;">
                           <button>
                           <input type="hidden" name="bedNumber" value="${bed.bedNumber}">
                           <input type="hidden" name="visitId" value="${visitId}">
                         <div class="foo green" style="text-align:center" >
                         <h5>Bed : ${bed.bedNumber}</h5>
                         <div align="center" style=" margin-top: 15px;">
                          <i style="font-size:50px;"class="fas fa-bed"></i></div>
                            </div>
                            </button>
                            </form>
                        </c:if>                              
                       <c:if test="${bed.status != 'Available'}">
                           <button style="opacity:0.2;" disabled>
                           <input type="hidden" name="bedNumber" value="${bed.bedNumber}">
                         <div class="foo red" style="text-align:center" >
                         <h5>Bed : ${bed.bedNumber}</h5>
                         <div align="center" style=" margin-top: 15px;">
                          <i style="font-size:50px;"class="fas fa-bed"></i></div>
                            </div>
                            </button>
                        </c:if>
                       </c:forEach>
                       </div>
                           
                        </c:when>
                        <c:otherwise>
                             <div style="text-align:center;">
                      <c:forEach items="${room.beds}" var="bed">
                    <c:if test="${bed.status == 'Available'}">
               
                           <button>
                           <input type="hidden" name="bedNumber" value="${bed.bedNumber}">
                         <div class="foo green" style="text-align:center" >
                         <h5>Bed : ${bed.bedNumber}</h5>
                         <div align="center" style=" margin-top: 15px;">
                          <i style="font-size:50px;"class="fas fa-bed"></i></div>
                            </div>
                            </button>
                           
                        </c:if>                     
                     <c:if test="${bed.status != 'Available'}">
	   				 					<form action="displayPatientDetails" method="post" style="display: inline;">
	   				
          				 <button onclick = "show()">
          				 <input type="hidden" name="bedNumber" value="${bed.bedNumber}">
          				  <input type="hidden" name="roomNumber" value="${bed.roomNumber}">
          				 
	        			 <div class="foo red" style="text-align:center" >
	        			 <h5>Bed : ${bed.bedNumber}</h5>
	        			 <div align="center" style=" margin-top: 15px;">
						  <i style="font-size:50px;"class="fas fa-bed"></i></div>
	   					 </div>
	   					 </button>
	   					 	   					 </form>
	   					 
	   				 </c:if>
                       </c:forEach><br>
                 
                    
                    
 </div>
                  	 	   				<c:if test="${PatientDetails != null}">
                  	 
                  	          <div id="myDIV" class = "BedInformation">  
                  	                   
                  	                  <h2 class = "details" >Patient Details</h2>
                  	                    
                  	                    	<table class="w3-table-all w3-hoverable sortable">

                     <thead>
                        <tr>
                           <td> Visit Id </td>
                           <td>Admit Date</td>
                           <td>FirstName</td>
                           <td>LastName</td>
                           <td>Email</td>
                           <td>Mobile Number</td>
                           <td>BirthDate</td>
                           <td>Gender</td>
                                        <td>Action</td>
                                         <td></td>
                           
                        </tr>
                     </thead>
                     <tbody id="myTable1">
                           <tr>
                              <td>${visitDetails.id}</td>
                              <td>${visitDetails.admitDate}</td>
                              <td>${visitDetails.patient.firstName}</td>
                              <td>${visitDetails.patient.lastName}</td>
                              <td>${visitDetails.patient.emailId}</td>
                              <td>${visitDetails.patient.mobileNumber}</td>
                              <td>${visitDetails.patient.birthDate}</td>
                              <td>${visitDetails.patient.gender}</td>
                              <td>
<form:form action="dischargePatient" method="post" >
                              <input type="hidden" name="bedNumber" value="${bedDetails.bedNumber}"/>
                 <button type="submit" style="width:70%;" onClick="return confirm('Are you sure you want to discharge Visit ${visitDetails.id}');" class="btn btn-danger">Discharge</button> 
                              </form:form>
</td>
<td>
                              <input type="hidden" name="bedNumber" value="${bedDetails.bedNumber}"/>
                              <button onclick = "myFunction()" style="width:75%;"  class="btn btn-primary">View History</button> 
</td>
                              </tr>
                              </tbody>
                              </table>
                  	          </div>





                  	          <div id="historyDetails" class = "BedInformation">  
                  	                   
                  	                  <h2 class = "details" >Bed Allocations Details</h2>
                  	                    
                  	                    	<table  class="w3-table-all w3-hoverable sortable">

                     <thead>
                        <tr>
                           <td> BedAllocation Id </td>
                           <td>Bed Number</td>
                           <td>Visit Id</td>
                           <td>Admit Date</td>
                           <td>Discharge Date</td>
                           
                                      
                           
                        </tr>
                     </thead>
                     <tbody id="myTable">
                                             <c:forEach items="${bedDetails.bedAllocations}" var="bedAllocation">
                     
                           <tr>
                              <td>${bedAllocation.bedAllocationId}</td>
                              <td>${bedAllocation.bed.bedNumber}</td>
                              <td>${bedAllocation.visit.id}</td>
                              <td>${bedAllocation.admitDate}</td>
                              <td>${bedAllocation.dischargeDate}</td>
                              

                              </tr>
                              </c:forEach>
                              </tbody>
                              </table>
                  	          </div>

                  	          </c:if>
                  	 </div>


                       </c:otherwise>
                    </c:choose>
 
                       
                       </div>
                  </div>
               </div>
            </div>
         </div>
         
        <c:choose>
         <c:when test="${not empty successMessage}">
            <div id="snackbar">${successMessage}</div>
            <script type="text/javascript">window.onload = function() {
               var x = document.getElementById("snackbar");
               x.className = "show";
               setTimeout(function(){ x.className = x.className.replace("show", ""); }, 3000);
               }  
            </script>
         </c:when>
      </c:choose>
<script>
function myFunction() {
    var x = document.getElementById("historyDetails");
    if (!x.style.display || x.style.display === "none") {
        x.style.display = "block";
    } else {
        x.style.display = "none";
    }}
</script>      </div>
      <jsp:include page="footer.jsp"/>
   </body>
</html>

