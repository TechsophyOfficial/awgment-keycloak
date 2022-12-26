<#macro registrationLayout bodyClass="" displayInfo=false displayMessage=true>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"  "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<head>
    <meta charset="utf-8">
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <meta name="robots" content="noindex, nofollow">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="shortcut icon" href="${url.resourcesPath}/img/favicon.ico" type="image/x-icon">
     <link href="https://fonts.googleapis.com/css2?family=Noto+Sans:wght@300;400;500;600;800&family=Roboto:ital,wght@0,400;0,900;1,700&display=swap" rel="stylesheet">
    <link rel="stylesheet" type="text/css" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css" />
    

    <title>Sign in to MedUnited</title>
    <#if properties.styles?has_content>
        <#list properties.styles?split(' ') as style>
            <link href="${url.resourcesPath}/${style}" rel="stylesheet" />
        </#list>
    </#if>
</head>

	<body>
        <#--  <#nested "header">  -->
         <div class="page-wrapper bg-gra-01 ">
         <div class="login-header">
            <div class="">
                <div class="logoDiv"><img src="${url.resourcesPath}/img/logo.png"/></div>
            </div>
           <#-- <div class="nav">
                <ul>
                    <li><a href="#">Start Billing </a></li>
                    <li><a href="#">Start Registration </a></li>
                </ul>
            </div>-->
         </div>
        <div class="wrapper wrapper--w780">
        <#if displayMessage && message?has_content>
        <div class="alert alert-${message.type}">
             <#if message.type = 'success'><span class="${properties.kcFeedbackSuccessIcon!}"></span></#if>
             <#if message.type = 'warning'><span class="${properties.kcFeedbackWarningIcon!}"></span></#if>
             <#if message.type = 'error'><span class="${properties.kcFeedbackErrorIcon!}"></span></#if>
             <#if message.type = 'info'><span class="${properties.kcFeedbackInfoIcon!}"></span></#if>
             <span class="message-text">${message.summary?no_esc}</span>
        </div>
        </#if>
        <#nested "form">
            </div> 
        </div>
	</body>
</html>
</#macro>