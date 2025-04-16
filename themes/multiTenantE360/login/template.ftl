<#macro registrationLayout bodyClass="" displayInfo=false displayMessage=true displayRequiredFields=false displayWide=false showAnotherWayIfPresent=true>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"  "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" class="${properties.kcHtmlClass!}">

<head>
    <meta charset="utf-8">
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <meta name="robots" content="noindex, nofollow">

    <#if properties.meta?has_content>
        <#list properties.meta?split(' ') as meta>
            <meta name="${meta?split('==')[0]}" content="${meta?split('==')[1]}"/>
        </#list>
    </#if>
    <title>${msg("loginTitle",(realm.displayName!''))}</title>
    <link rel="icon" href="${url.resourcesPath}/img/augment-logo.svg" />
    <#if properties.stylesCommon?has_content>
        <#list properties.stylesCommon?split(' ') as style>
            <link href="${url.resourcesCommonPath}/${style}" rel="stylesheet" />
        </#list>
    </#if>
    <#if properties.styles?has_content>
        <#list properties.styles?split(' ') as style>
            <link href="${url.resourcesPath}/${style}" rel="stylesheet" />
        </#list>
    </#if>
    <#if properties.scripts?has_content>
        <#list properties.scripts?split(' ') as script>
            <script src="${url.resourcesPath}/${script}" type="text/javascript"></script>
        </#list>
    </#if>
    <#if scripts??>
        <#list scripts as script>
            <script src="${script}" type="text/javascript"></script>
        </#list>
    </#if>
</head>

<body class="${properties.kcBodyClass!}">
<div class="body-wrapper">
<div class="full-height welcome">
    <div style="height:100vh; position: relative;">
        <div class="large-logo-container">
            <img id="tenant-logo" src="" alt="" class="large-logo"/>
        </div>
    </div>
</div>

<div class="login-wrap">
  <div class="${properties.kcLoginClass!}" >
    <#--  <div id="kc-header" class="${properties.kcHeaderClass!}">
      <div id="kc-header-wrapper" class="${properties.kcHeaderWrapperClass!}"></div>
    </div>  -->
    
    <#--  <img src="${url.resourcesPath}/img/emp360InnovationsText.svg" alt="text" style="width:65px;margin-left:20px" />  -->
    
    <div class="${properties.kcFormCardClass!} <#if displayWide>${properties.kcFormCardAccountClass!}</#if>">
      <header class="${properties.kcFormHeaderClass!}">
        <#if realm.internationalizationEnabled  && locale.supported?size gt 1>
            <div id="kc-locale">
                <div id="kc-locale-wrapper" class="${properties.kcLocaleWrapperClass!}">
                    <div class="kc-dropdown" id="kc-locale-dropdown">
                        <a href="#" id="kc-current-locale-link">${locale.current}</a>
                        <ul>
                            <#list locale.supported as l>
                                <li class="kc-dropdown-item"><a href="${l.url}">${l.label}</a></li>
                            </#list>
                        </ul>
                    </div>
                </div>
            </div>
        </#if>
        <#if !(auth?has_content && auth.showUsername() && !auth.showResetCredentials())>
            <#if displayRequiredFields>
                <div class="${properties.kcContentWrapperClass!}">
                    <div class="${properties.kcLabelWrapperClass!} subtitle">
                        <span class="subtitle"><span class="required">*</span> ${msg("requiredFields")}</span>
                    </div>
                    <div class="col-md-10">
                        <h1 id="kc-page-title"><#nested "header"></h1>
                    </div>
                </div>
            <#else>
            </#if>
        <#else>
            <#if displayRequiredFields>
                <div class="${properties.kcContentWrapperClass!}">
                    <div class="${properties.kcLabelWrapperClass!} subtitle">
                        <span class="subtitle"><span class="required">*</span> ${msg("requiredFields")}</span>
                    </div>
                    <div class="col-md-10">
                        <#nested "show-username">
                        <div class="${properties.kcFormGroupClass!}">
                            <div id="kc-username">
                                <label id="kc-attempted-username">${auth.attemptedUsername}</label>
                                <a id="reset-login" href="${url.loginRestartFlowUrl}">
                                    <div class="kc-login-tooltip">
                                        <i class="${properties.kcResetFlowIcon!}"></i>
                                        <span class="kc-tooltip-text">${msg("restartLoginTooltip")}</span>
                                    </div>
                                </a>
                            </div>
                        </div>
                    </div>
                </div>
            <#else>
                <#nested "show-username">
                <div class="${properties.kcFormGroupClass!}">
                    <div id="kc-username">
                        <label id="kc-attempted-username">${auth.attemptedUsername}</label>
                        <a id="reset-login" href="${url.loginRestartFlowUrl}">
                            <div class="kc-login-tooltip">
                                <i class="${properties.kcResetFlowIcon!}"></i>
                                <span class="kc-tooltip-text">${msg("restartLoginTooltip")}</span>
                            </div>
                        </a>
                    </div>
                </div>
            </#if>
        </#if>
      </header>
      <div id="kc-content">
      <div class="small-screen-logo">
        <div class="small-logo-container">
            <img id="small-screen-tenant-logo" src="" alt="" class="small-screen-logo-img" />
        </div>
      </div>
        <div id="kc-content-wrapper">

          <#-- App-initiated actions should not see warning messages about the need to complete the action -->
          <#-- during login.                                                                               -->
          <#if displayMessage && message?has_content && (message.type != 'warning' || !isAppInitiatedAction??)>
              <div class="alert alert-${message.type}">
                  <#if message.type = 'success'><span class="${properties.kcFeedbackSuccessIcon!}"></span></#if>
                  <#if message.type = 'warning'><span class="${properties.kcFeedbackWarningIcon!}"></span></#if>
                  <#if message.type = 'error'><span class="${properties.kcFeedbackErrorIcon!}"></span></#if>
                  <#if message.type = 'info'><span class="${properties.kcFeedbackInfoIcon!}"></span></#if>
                  <span class="kc-feedback-text">${kcSanitize(message.summary)?no_esc}</span>
              </div>
          </#if>

          <#nested "form">

          <#if auth?has_content && auth.showTryAnotherWayLink() && showAnotherWayIfPresent>
          <form id="kc-select-try-another-way-form" action="${url.loginAction}" method="post" <#if displayWide>class="${properties.kcContentWrapperClass!}"</#if>>
              <div <#if displayWide>class="${properties.kcFormSocialAccountContentClass!} ${properties.kcFormSocialAccountClass!}"</#if>>
                  <div class="${properties.kcFormGroupClass!}">
                    <input type="hidden" name="tryAnotherWay" value="on" />
                    <a href="#" id="try-another-way" onclick="document.forms['kc-select-try-another-way-form'].submit();return false;">${msg("doTryAnotherWay")}</a>
                  </div>
              </div>
          </form>
          </#if>

          <#if displayInfo>
              <div id="kc-info" class="${properties.kcSignUpClass!}">
                  <div id="kc-info-wrapper" class="${properties.kcInfoAreaWrapperClass!}">
                      <#nested "info">
                  </div>
              </div>
          </#if>
        </div>
      </div>

    </div>
  </div>
  </div>
 </div>
 
   <script>
    (function () {
        // Extract realm from URL
        var realmMatch = window.location.pathname.match(/\/realms\/([^/]+)/);
        var realm = realmMatch ? realmMatch[1] : null;

        if (!realm) {
            console.error("Realm not found in URL");
            return;
        }

        var jsonUrl = `https://apps-dev.techsophy.com/emp360/${realm}.json`;

        function applyBackgrounds(data) {
            var largeScreenLogo = document.getElementById('tenant-logo');
            var smallScreenLogo = document.getElementById('small-screen-tenant-logo');
            var largeScreenBgDiv = document.querySelector('.welcome');
            var smallScreenBgDiv = document.querySelector('.login-pf-page');

            if (data && data.keycloakLogoUrl) {
                if (largeScreenLogo) {
                    largeScreenLogo.src = data.keycloakLogoUrl;
                    largeScreenLogo.alt = realm;
                }
                if (smallScreenLogo) {
                    smallScreenLogo.src = data.keycloakLogoUrl;
                    smallScreenLogo.alt = realm;
                }
            } else {
                if (largeScreenLogo) {
                    largeScreenLogo.src = "";
                    largeScreenLogo.alt = realm;
                }
                if (smallScreenLogo) {
                    smallScreenLogo.src = "";
                    smallScreenLogo.alt = realm;
                }
            }

            if (data && data.keycloakBackgroundImageUrl && largeScreenBgDiv) {
                largeScreenBgDiv.style.backgroundImage = 'url("' + data.keycloakBackgroundImageUrl + '")';
            } else if (largeScreenBgDiv) {
                largeScreenBgDiv.style.backgroundImage = "url('${url.resourcesPath}/img/defaultBG.png')";
            }

            if (window.innerWidth <= 1024 && smallScreenBgDiv) {
                if (data && data.keycloakBackgroundImageUrl) {
                    smallScreenBgDiv.style.backgroundImage = 'url("' + data.keycloakBackgroundImageUrl + '")';
                } else {
                    smallScreenBgDiv.style.backgroundImage = "url('${url.resourcesPath}/img/defaultBG.png')";
                }
            }
            if (window.innerWidth > 1024 && smallScreenBgDiv) {
                smallScreenBgDiv.style.backgroundImage = "";
            }
        }

        fetch(jsonUrl)
            .then(response => {
                if (!response.ok) {
                    throw new Error("Network response was not ok");
                }
                return response.json();
            })
            .then(data => {
                applyBackgrounds(data);
                window.addEventListener('resize', () => applyBackgrounds(data));
            })
            .catch(error => {
                console.error("Error fetching tenant logo/background:", error);
                applyBackgrounds(null); 
            });
    })();
</script>


</body>
</html>
</#macro>




