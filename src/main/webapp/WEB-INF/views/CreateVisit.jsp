<%@ page language="java" contentType="text/html; charset=utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<jsp:include page="access.jsp" />
</head>
<body>
	<jsp:include page="header.jsp" />
	<div id="wrapper">
		<div id="sidebar-wrapper">
			<ul class="sidebar-nav">
				<li class="sidebar-brand"><a href="index"> Home </a></li>
				<li class="highlight"><a href="searchVisitByPatientId">Visit
				</a></li>
				<li><a href="displayVisits">Display Visits</a></li>
				<li><a href="createPatient">Create Patient</a></li>
				<li><a href="displayPatients">Display Patients</a></li>
			</ul>
		</div>
		<div id="page-content-wrapper">
		<jsp:include page="ReceptionistHeader.jsp" />
		<c:choose>
		 <c:when test="${empty sessionScope.patient}">
		   <h2>No Patient Selected.</h2> 
		   <h2>Search Patient to create Visit</h2>
		 </c:when>
		 <c:otherwise>
			<c:choose>
				<c:when test="${empty visit.id}">
					<c:set var="value" value="addVisit" />
				</c:when>
				<c:otherwise>
					<c:set var="value" value="updateVisit" />
				</c:otherwise>
			</c:choose>
			<div class="row">
				<c:choose>
					<c:when test="${empty visit.id}">

						<form:form action="${value}" commandName="visit">
							<legend>
								<c:if test="${empty visit.id}">
                Add Visit Details
              </c:if>
								<c:if test="${not empty visit.id}">
                Modify Visit Details
              </c:if>
							</legend>
							<input type="hidden" name="patientId" value="${sessionScope.patient.id}">
							<div class="form-group">
								<label class="col-sm-2 control-label" for="Specialisation">Specialisation</label>
								<div class="col-sm-10">
									<select class="inputtext" id='specialisation'>
										<c:forEach items="${specialisations}" var="specialisation">
											<c:if test="${specialisation != selected}">
												<option value="${specialisation}">${specialisation}</option>
											</c:if>
										</c:forEach>
									</select>
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-2 control-label" for="Physician">Physician</label>
								<div class="col-sm-10">
									<select class="inputtext" id="sel_user">
										<option value="0">- Select -</option>
									</select> <input type="hidden" name="physicianId" id="physicianId" />
								</div>
							</div>
							<label class="col-sm-2 control-label" for="PatientType">Patient
								Type</label>
							<div class="col-sm-10">
								<form:select class="inputtext" path="patientType"
									items="${types}" />
							</div>
							<c:if test="${not empty visit.id}">
								<input type="hidden" name="id" value="${visit.id}" />
							</c:if>
			<c:choose>
				<c:when test="${empty visit.id}">
					<input type="submit" class="btn btn-info center buttn"
						value="ADD VISIT">
				</c:when>
				<c:otherwise>
					<input type="submit" class="btn btn-info center buttn"
						value="MODIFY VISIT DETAILS"
						onclick="return confirm('Sure want to make changes on the Visit?')">
				</c:otherwise>
			</c:choose>
			</form:form>
			</c:when>
			<c:otherwise>
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
                </tr>
                </tbody>
                </table>
			</c:otherwise>
			</c:choose>
		</div>
		</c:otherwise>
		</c:choose>
	</div>
</body>
<jsp:include page="footer.jsp" />
</html>