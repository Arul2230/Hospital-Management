<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
   pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
   <link rel="shortcut icon" href="images/i2i.png" />
   <head>
      <title>Hospital Management System</title>
      <META HTTP-EQUIV="Pragma" CONTENT="no-cache">
      <META HTTP-EQUIV="Expires" CONTENT="-1">
            <jsp:include page="access.jsp"/>
   </head>
   <body>
         <jsp:include page="header.jsp"/>
                          <div id="wrapper">
        <div id="sidebar-wrapper">
            <ul class="sidebar-nav">
                <li class="sidebar-brand">
                    <a href="index">
                        Home
                    </a>
                </li>
                <li >
             <a href="createVisit">Create Visit </a> 
                </li>
             <li>
              <a href="displayVisits">Display Visits</a> 
                </li>
                <li>
	           <a href="createPatient">Create Patient</a>
                </li>
                 <li>
	           <a href="displayPatients">Display Patients</a>
                </li>
            </ul>
        </div>
              <div id="page-content-wrapper">
              <form action="searchVisit" method="post">
  <input type="number" style="margin-left:42%" name="id" placeholder="Search Visit By Id">
</form>
                    <div align="center" >
         <table class ="table">
               <caption>
                  <h2>Visit-${visit.id} Details</h2>
               </caption>
            <thead>
               <tr>
                  <th>ID</th>
                  <th>ADMIT DATE</th>
                  <th>DISCHARGE DATE</th>
                  <th>PATIENT TYPE</th>
               </tr>
            </thead>
            <tbody>
                  <tr>
                     <td>
                        <c:out value="${visit.id}" />
                     </td>
                     <td>
                        <c:out value="${visit.admitDate}" />
                     </td>
                     <td>
                        <c:out value="${visit.dischargeDate}" />
                     </td>
                     <td>
                        <c:out value="${visit.patientType}" />
                     </td>
                  </tr>
            </tbody>
         </table>
         <table class ="table">
            <thead>
               <tr>
                  <th>PATIENT ID</th>
                  <th>PATIENT NAME</th>                  
                  <th>PATIENT EMAILID</th>
                  <th>PATIENT GENDER</th>
                  <th>PATIENT MOBILENUMBER</th>
               </tr>
            </thead>
            <tbody>
               <tr>
                 <td>
                     <c:out value="${visit.patient.id}" />
                </td>
                <td>
                     <c:out value="${visit.patient.firstName} ${visit.patient.lastName}" />
                </td>
                <td>
                     <c:out value="${visit.patient.emailId}" />
                </td>
                <td>
                     <c:out value="${visit.patient.gender}" />
                </td>
                <td>
                     <c:out value="${visit.patient.mobileNumber}" />
                </td>
                </tr>
                </tbody>
                </table>
         <table class ="table">
            <thead>
               <tr>
                  <th>PHYSICIAN ID</th>
                  <th>PHYSICIAN NAME</th>
                  <th>PHYSICIAN EMAILID</th>
                  <th>PHYSICIAN MOBILENUMBER</th>
                  <th>PHYSICIAN SPECIALISATION</th>
               </tr>
            </thead>
            <tbody>
               <tr>
                     <td>
                       <c:out value="${visit.physician.id}" />
                     </td>
                     <td>
                        <c:out value="${visit.physician.firstName} ${visit.physician.lastName}" />
                     </td>
                <td>
                     <c:out value="${visit.physician.email}" />
                </td>
                <td>
                     <c:out value="${visit.physician.mobileNumber}" />
                </td>
                <td>
                     <c:out value="${visit.physician.specialisation}" />
                </td>
                </tr>
                </tbody>
                </table>
      </div>
            </div>
      
            </div>
      
   </body>
         <jsp:include page="footer.jsp"/>
</html>