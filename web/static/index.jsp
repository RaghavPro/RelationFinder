<%--
Created by IntelliJ IDEA.
User: RaghavFTW
Date: 17/12/15
Time: 23:24
To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title></title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css"
          integrity="sha384-1q8mTJOASx8j1Au+a5WDVnPi2lkFfwwEAa8hDDdjZlpLegxhjVME1fgjWPGmkzs7" crossorigin="anonymous">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap-theme.min.css"
          integrity="sha384-fLW2N01lMqjakBkx3l/M9EahuwpSfeNvV63J5ezn3uZzapT0u7EYsXMjQV+0En5r" crossorigin="anonymous">
</head>
<body>
    <div class="container">
        <div class="col-md-6 center-block" style="float:none">
            <h1 class="text-center">Find Relation</h1>
            <form action="/find">
                <div class="input-group">
                    <input class="form-control" type="text" name="query" placeholder="father's mother's daughter"
                    <c:if test="${requestScope.query != null}">
                      value="${requestScope.query}"
                    </c:if>
                    >
                    <div class="input-group-btn btn-default">
                        <button class="btn btn-primary" type="submit">Submit</button>
                    </div>
                </div>
            </form>
            <c:if test="${requestScope.results != null}">
                <ol>
                    <c:forEach var="result" items="${requestScope.results}">
                        <li>
                            <c:forEach var="relation" items="${result}">
                                ${relation}
                            </c:forEach>
                        </li>
                    </c:forEach>
                </ol>
            </c:if>
        </div>
    </div>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js"
        integrity="sha384-0mSbJDEHialfmuBBQP6A4Qrprq5OVfW37PRR3j5ELqxss1yVqOtnepnHVP9aJ7xS"
        crossorigin="anonymous"></script>
</body>
</html>