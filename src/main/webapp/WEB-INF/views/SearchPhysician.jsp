<%@ page language="java" contentType="text/html; charset=UTF-8"
  pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
  "http://www.w3.org/TR/html4/loose.dtd">
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Physician Details</title>
    <link rel="shortcut icon" href="styles/images/ideas1.jpg"/>
    <META HTTP-EQUIV="Pragma" CONTENT="no-cache">
    <META HTTP-EQUIV="Expires" CONTENT="-1">
  </head>
  <body>
    <c:if test="${not empty message}">
     <div id="snackbar">${message}</div>
    </c:if>

      <div class="row full-width">
        <div class="col-sm-4 col-xs-4 text-align-center"> 
          <a href="createPhysician">
          <button class="btn-margin-format add-button">
          Add New Physician
          </button>
          </a>
        </div>
        <div class="col-sm-4 col-xs-4 search-bar-display">
           <form  autocomplete="off" class="form-inline" action="searchPhysician" method="get">
              <input name="id"  type="number" class="form-control mr-sm-2" placeholder="Search"  required>
              <button class="glyphicon glyphicon-search"  type="submit"/>    
            </form>
        </div>
        <div class="col-sm-4 col-xs-4 text-align-center">
           <a href="displayPhysicians">
          <button class="btn-margin-format add-button">
             View All Physicians
          </button>
          </a>
        </div>
      </div>
    <jsp:useBean id="now" class="java.util.Date" />
    <fmt:formatDate var="currentyear" value="${now}" pattern="yyyy" />
<div class="container">
  <ul class="pager">
     <input type="hidden" id="pager-id" value="${physician.id}">
    <li id="previous" class="previous"><a id="previous-link" href="searchPhysician?id=${physician.id-1}">Previous</a></li>
     <li> <b>Physician Details</b></li>
    <li id="next" class="next"><a href="searchphysician?id=${physician.id+1}">Next</a></li>
  </ul>
</div>
    <c:if  test="${empty physician.id}">
      <h2 align="center">${failMessage}.</h2>
    </c:if>
    <c:if  test="${not empty physician.id}">
      <div align="center">
        <table border="1" cellpadding="5" class="table ">
          <tr>
            <th>ID</th>
            <th>Name</th>
            <th>Email</th>
            <th>Gender</th>
            <th>Specialisation</th>
            <th>DOB</th>
            <th>Mobile Number</th>
            <th>Age</th>
            <th>#</th>
            <c:if test="${physician.isActive()}">
              <th>#</th>
            </c:if>
          </tr>
          <tr>
            <td>
              <c:out value="${physician.id}"/>
            </td>
            <td>
              <c:out value="${physician.firstName} ${physician.lastName}"/>
            </td>
            <td>
              <c:out value="${physician.email}"/>
            </td>
            <td>
              <c:out value="${physician.gender}"/>
            </td>
            <td>${physician.specialisation}</td>
            <td>${physician.birthDate}</td>
            <td>${physician.mobileNumber}</td>
            <td>${physician.age} years</td>
            <c:if test="${!physician.isActive()}">
              <td colspan="2" class="type">
                <form action ="restorePhysician" method="POST">
                  <input type="hidden" name="id" value="${physician.id}"/>
                  <button type="submit" class="btn-margin-format">Restore</button>
                </form>
              </td>
            </c:if>
            <c:if test="${physician.isActive()}">
              <form action = "modifyPhysician" method = "GET">
                <input type="hidden" name="id" value="${physician.id}"/>
                <td><input type="submit" class="btn btn-primary" value="Update"></td>
              </form>
              <form action ="deletePhysician" method="POST">
                <input type="hidden" name="id" value="${physician.id}"/>
                <td class="type"><button type="submit"  class="btn-danger" onclick="return confirm('Delete physician id : ${physician.id} ?')" >Delete </button></td>
              </form>
            </c:if>
          </tr>
        </table>
      </div>
    </c:if>
    <c:if test="${not empty physician.address}">
      <table border="1" cellpadding="5" class="table">
        <tr>
          <th>Type</th>
          <th>Door-Number</th>
          <th>Street</th>
          <th>City</th>
          <th>Country</th>
          <th>Pin-Code</th>
        </tr>
          <tr>
            <td>
              <c:out value="${address.type}"/>
            </td>
            <td>
              <c:out value="${address.doorNumber}"/>
            </td>
            <td>
              <c:out value="${address.street}"/>
            </td>
            <td>
              <c:out value="${address.city}"/>
            </td>
            <td>
              <c:out value="${address.country}"/>
            </td>
            <td>
              <c:out value="${address.pinCode}"/>
            </td>
          </tr>
        </c:forEach>
      </table>
    </c:if>
    <c:if test="${not empty employee.workingProjects}">
      <div align="center"><h3>${employee.name}'s Projects</h3></div>
       <div class="scrollable-project-search">
      <table border="1" cellpadding="5" class="table">
        <tr>
          <th>ID</th>
          <th>Name</th>
          <th>Resources</th>
        </tr>
        <c:forEach var="project" items="${employee.workingProjects}">
          <tr>
            <td>
              <c:out value="${project.id}"/>
            </td>
            <td>
              <form action="search_project" method="get"><button type="submit" class="button-as-link">${project.name}</button>
                <input type="hidden" name="id" value="${project.id}" /> 
              </form>
            </td>
            <td>
              <c:out value="${project.numberOfResources}"/>
            </td>
          </tr>
        </c:forEach>
      </table></div>
    </c:if>
  </body>
  <script src="script/script.js"></script>
</html>