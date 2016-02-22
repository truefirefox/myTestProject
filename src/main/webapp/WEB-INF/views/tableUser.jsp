
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<html>

<head>
    <title>My CRUD</title>
    <style type="text/css">
        .tg  {border-collapse:collapse;border-spacing:0;border-color: #95c7cc;}
        .tg td{font-family:Arial, sans-serif;font-size:14px;padding:10px 3px;border-style:solid;border-width:1px;overflow:hidden;word-break:normal;border-color: #2d39cc;color:#333;background-color: #bcd8ff;}
        .tg th{font-family:Arial, sans-serif;font-size:14px;font-weight:normal;padding:10px 5px;border-style:solid;border-width:1px;overflow:hidden;word-break:normal;border-color: #bcd8ff;color:#333;background-color: #4081ff;}
    </style>
</head>

<body>
<table width="100%" border="0" cellspacing="5">
    <tr>
        <%-- Users --%>
        <td valign="top" align="center">
            <c:if test= "${user.id == 0}">
                <c:if test="${empty listUsers}">
                    <h2> <i>Пользователь не найден </i></h2>
                </c:if>

                <c:if test="${!empty listUsers}">
                    <h2> <i>Список пользователей </i></h2>
                    <table class="tg">
                        <tr>
                            <th width="60" style='text-align:center'>id</th>
                            <th width="120" style='text-align:center'>Name</th>
                            <th width="60" style='text-align:center'>Age</th>
                            <th width="60" style='text-align:center'>isAdmin</th>
                            <th width="80" style='text-align:center'>Date</th>
                            <th width="40" style='text-align:center'>Edit</th>
                            <th width="40" style='text-align:center'>Delete</th>
                        </tr>
                        <c:forEach items="${listUsers}" var="user">
                            <tr>
                                <td width="60" style='text-align:center'>${user.id}</td>
                                <td width="120" style='text-align:center'>${user.name}</td>
                                <td width="60" style='text-align:center'>${user.age}</td>
                                <td width="60" style='text-align:center'>${user.isAdmin}</td>
                                <td width="80" style='text-align:center'>${user.createdDate}</td>
                                <td width="40" style='text-align:center'><a href="<c:url value='/edit/${user.id}' />" > Edit </a></td>
                                <td width="40" style='text-align:center'><a href="<c:url value='/remove/${user.id}' />" > Delete </a></td>
                            </tr>
                        </c:forEach>
                    </table>

                    <%-- Paging --%>
                    <c:url var="search" value="/users" ></c:url>
                    <table>
                        <tr>
                            <td>
                                <form:form action="${search}" method ="POST" commandName="pageProperty" >
                                    <form:input path="pageNumber" type="hidden" value="${pageProperty.pageNumber-1}"/>
                            <td><input type="submit" value="пред."/></td>
                            </form:form>
                            </td>
                            <td>Стр. ${pageProperty.pageNumber} / ${pageProperty.size}</td>
                            <td>
                                <form:form action="${search}" method ="POST" commandName="pageProperty" >
                                    <form:input path="pageNumber" type="hidden" value="${pageProperty.pageNumber+1}"/>
                            <td><input type="submit" value="след."/></td>
                            </form:form>
                            </td>
                            <td>
                                <form:form action="${search}" method ="POST" commandName="pageProperty" >
                            <td> перейти на стр. </td>
                            <td><form:input path="pageNumber" /></td>
                            <td><input type="submit" value="ok" /></td>
                            </form:form>
                        </tr>
                    </table>
                </c:if>
            </c:if>
        </td>

        <td width="40%" valign="top" align="center">
            <h2>
                <c:if test= "${user.id != 0}">
                    <i>Редактировать пользователя</i>
                </c:if>
                <c:if test= "${user.id == 0}">
                    <i>Добавить пользователя</i>
                </c:if>
            </h2>

            <%-- add/edit User --%>
            <c:url var="addAction" value="/user/add" ></c:url>
            <form:form action="${addAction}" commandName="user">
                <c:if test= "${user.id != 0}">
                    <b><p style="font-size:18px" align="center"> Пользователь № ${user.id}</p></b>
                </c:if>
                <table>
                    <tr>
                        <td><form:hidden path="id" /></td>
                    </tr>
                    <tr><td>Имя : </td><td><form:input path="name" /></td></tr>
                    <tr><td>Возраст : </td><td><form:input path="age" /></td></tr>
                    <tr>
                        <td>Админ : </td>
                        <td>
                            <form:radiobutton path="isAdmin" value="true" label="yes"/>
                            <form:radiobutton path="isAdmin" value="false" label="no"/>
                        </td>
                    </tr>
                    <tr><td>Дата : </td><td><form:input path="createdDate" type="date"/></td></tr>
                    <tr>
                        <td colspan="2" align="center">
                            <c:if test="${user.id != 0}">
                                <input type="submit" value="изменить" />
                            </c:if>
                            <c:if test="${user.id == 0}">
                                    <input type="submit" value="добавить" />
                            </c:if>
                        </td>
                    </tr>
                </table>
            </form:form>

            <%-- search User --%>
            <c:url var="search" value="/users" ></c:url>
            <form:form action="/users" method ="POST" commandName="pageProperty" >
                <h2><i>Поиск по имени: </i></h2>
                <table>
                    <tr>
                        <td><form:input path="nameFilter" /></td>
                        <td><input type="submit" value="искать"/></td>
                    </tr>
                </table>
            </form:form>
        </td>
    </tr>
</table>
</body>
</html>