<#import "template.ftl" as layout>

<@layout.registrationLayout 
    displayMessage=!(messagesPerField.getFirstError('username','password')??)
    displayInfo=realm.password && realm.registrationAllowed && !registrationDisabled??; 
section>

    <#if section = "header">
        ${msg("loginAccountTitle")}

    <#elseif section = "form">

    <div id="kc-form">
      <div id="kc-form-wrapper">

        <#if realm.password>
            <form id="kc-form-login" 
                  onsubmit="login.disabled = true; return true;" 
                  action="${url.loginAction}" 
                  method="post">
                
                <!-- USERNAME FIELD -->
                <div class="${properties.kcFormGroupClass!}">
                    <label for="username" class="${properties.kcLabelClass!}">
                        <#if !realm.loginWithEmailAllowed>
                            ${msg("username")}
                        <#elseif !realm.registrationEmailAsUsername>
                            ${msg("usernameOrEmail")}
                        <#else>
                            ${msg("email")}
                        </#if>
                    </label>

                    <#if usernameEditDisabled??>
                        <input tabindex="1" id="username" class="${properties.kcInputClass!}"
                               name="username" value="${(login.username!'')}" 
                               type="text" disabled />

                    <#else>

                        <input tabindex="1" id="username" class="${properties.kcInputClass!}" 
                               name="username" value="${(login.username!'')}"
                               type="text" autofocus autocomplete="off"
                               aria-invalid="<#if messagesPerField.getFirstError('username','password')??>true</#if>"
                        />

                        <!-- USERNAME/PASSWORD ERROR MESSAGE -->
                        <#if messagesPerField.getFirstError('username','password')??>
                            <span id="input-error"
                                  class="${properties.kcInputErrorMessageClass!}"
                                  aria-live="polite">
                                ${kcSanitize(messagesPerField.getFirstError('username','password'))?no_esc}
                            </span>
                        </#if>

                    </#else>
                    </#if>
                </div>

                <!-- PASSWORD FIELD -->
                <div class="${properties.kcFormGroupClass!}">
                    <label for="password" class="${properties.kcLabelClass!}">
                        ${msg("password")}
                    </label>

                    <input tabindex="2" id="password" class="${properties.kcInputClass!}" 
                           name="password" type="password" autocomplete="off"
                           aria-invalid="<#if messagesPerField.getFirstError('username','password')??>true</#if>"
                    />
                </div>

                <!-- REMEMBER ME + FORGOT PASSWORD -->
                <div class="${properties.kcFormGroupClass!} ${properties.kcFormSettingClass!}">
                    <div id="kc-form-options">

                        <#if realm.rememberMe && !usernameEditDisabled??>
                            <div class="checkbox">
                                <label>
                                    <#if login.rememberMe??>
                                        <input tabindex="3" id="rememberMe" 
                                               name="rememberMe" type="checkbox" checked> 
                                               ${msg("rememberMe")}
                                    <#else>
                                        <input tabindex="3" id="rememberMe"
                                               name="rememberMe" type="checkbox"> 
                                               ${msg("rememberMe")}
                                    </#if>
                                </label>
                            </div>
                        </#if>

                    </div>

                    <div class="${properties.kcFormOptionsWrapperClass!} forgot-password">
                        <#if realm.resetPasswordAllowed>
                            <span>
                                <a tabindex="5" href="${url.loginResetCredentialsUrl}">
                                    ${msg("doForgotPassword")}
                                </a>
                            </span>
                        </#if>
                    </div>
                </div>

                <!-- SUBMIT BUTTON -->
                <div id="kc-form-buttons" class="${properties.kcFormGroupClass!}">
                    <input type="hidden" id="id-hidden-input" name="credentialId"
                           <#if auth.selectedCredential?has_content>
                               value="${auth.selectedCredential}"
                           </#if>
                    />
                    
                    <input tabindex="4"
                           class="${properties.kcButtonClass!} 
                                  ${properties.kcButtonPrimaryClass!} 
                                  ${properties.kcButtonBlockClass!} 
                                  ${properties.kcButtonLargeClass!}"
                           name="login" id="kc-login" 
                           type="submit" value="${msg("doLogIn")}" />
                </div>

            </form>
        </#if>
      </div>

      <!-- SOCIAL LOGIN PROVIDERS -->
      <#if realm.password && social.providers??>
          <div id="kc-social-providers" class="${properties.kcFormSocialAccountSectionClass!}">
              <hr/>
              <h4>${msg("identity-provider-login-label")}</h4>

              <ul class="${properties.kcFormSocialAccountListClass!} 
                  <#if social.providers?size gt 3>
                      ${properties.kcFormSocialAccountListGridClass!}
                  </#if>">

                  <#list social.providers as p>
                      <a id="social-${p.alias}" 
                         class="${properties.kcFormSocialAccountListButtonClass!}
                                <#if social.providers?size gt 3>
                                    ${properties.kcFormSocialAccountGridItem!}
                                </#if>"
                         type="button" href="${p.loginUrl}">
                         
                          <#if p.iconClasses?has_content>
                              <i class="${properties.kcCommonLogoIdP!} ${p.iconClasses!}" aria-hidden="true"></i>
                              <span class="${properties.kcFormSocialAccountNameClass!} kc-social-icon-text">
                                  ${p.displayName!}
                              </span>
                          <#else>
                              <span class="${properties.kcFormSocialAccountNameClass!}">
                                  ${p.displayName!}
                              </span>
                          </#if>
                      </a>
                  </#list>
              </ul>
          </div>
      </#if>

    </div>

    <#elseif section = "info">

        <#if realm.password && realm.registrationAllowed && !registrationDisabled??>
            <div id="kc-registration-container">
                <div id="kc-registration">
                    <span style="color:#444444;font-size:0.8rem">
                        New to Channel 360? 
                        <a tabindex="6" href="${url.registrationUrl}">
                            ${msg("doRegister")} for free
                        </a>
                    </span>
                </div>
            </div>
        </#if>

    </#if>

</@layout.registrationLayout>
