<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<link rel="shortcut icon" href="${pageContext.request.contextPath}/assets/images/logo/favicon.ico" type="image/x-icon">
<link rel="icon" href="${pageContext.request.contextPath}/assets/images/logo/favicon.png" type="image/png">

<style>
/* 클릭 가능한 요소에 커서 포인터 적용 */
a,
button,
input[type="submit"],
input[type="button"],
input[type="checkbox"],
input[type="radio"],
label[for],
select,
textarea,
.cursor-pointer,
i.fa,
[class*="btn"],
[class*="icon"],
[class*="link"]
{
  cursor: pointer;
}
  /* 전체 페이지에서 기본적으로 텍스트 선택 및 캐럿 표시 금지 */
  body, html {
    user-select: none;
    caret-color: transparent;
  }

  /* 입력 가능한 요소에서는 다시 허용 */
  input,
  textarea,
  select,
  [contenteditable="true"] {
    user-select: text;
    caret-color: auto;
  }

</style>
