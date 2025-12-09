<#import "template.ftl" as layout>
<@layout.mainLayout active='account' bodyClass='user'; section>

    <script src="https://cdn.jsdelivr.net/npm/vue"></script>
    <script src="https://unpkg.com/axios/dist/axios.min.js"></script>
    <script src="https://www.recaptcha.net/recaptcha/api.js?onload=onloadCallback&render=explicit" async defer></script>

    <style>
        [v-cloak] > * { display:none; }
        [v-cloak]::before { content: "loading..."; }
    </style>

    <div class="row">
        <div class="col-md-10">
            <h2>${msg("editAccountHtmlTitle")}</h2>
        </div>
        <div class="col-md-2 subtitle">
            <span class="subtitle"><span class="required">*</span> ${msg("requiredFields")}</span>
        </div>
    </div>

    <div id="vue-app">
        <form action="${url.accountUrl?remove_ending("/")?remove_ending("account")}phone_account/" class="form-horizontal" method="post">

            <div class="alert alert-error" v-show="errorMessage">
                <span class="${properties.kcFeedbackErrorIcon!}"></span>
                <span class="kc-feedback-text">{{ errorMessage }}</span>
            </div>

            <input type="hidden" id="stateChecker" name="stateChecker" value="${stateChecker}">

            <div class="form-group ${messagesPerField.printIfExists('username','has-error')}">
                <div class="col-sm-2 col-md-2">
                    <label for="username" class="control-label">${msg("username")}</label> <#if realm.editUsernameAllowed><span class="required">*</span></#if>
                </div>

                <div class="col-sm-10 col-md-10">
                    <input type="text" class="form-control" id="username" name="username" <#if !realm.editUsernameAllowed>disabled="disabled"</#if> value="${(account.username!'')}"/>
                </div>
            </div>

            <div class="form-group ${messagesPerField.printIfExists('email','has-error')}">
                <div class="col-sm-2 col-md-2">
                <label for="email" class="control-label">${msg("email")}</label> <span class="required">*</span>
                </div>

                <div class="col-sm-10 col-md-10">
                    <input type="text" class="form-control" id="email" name="email" autofocus value="${(account.email!'')}"/>
                </div>
            </div>

            <div class="form-group ${messagesPerField.printIfExists('firstName','has-error')}">
                <div class="col-sm-2 col-md-2">
                    <label for="firstName" class="control-label">${msg("firstName")}</label> <span class="required">*</span>
                </div>

                <div class="col-sm-10 col-md-10">
                    <input type="text" class="form-control" id="firstName" name="firstName" value="${(account.firstName!'')}"/>
                </div>
            </div>

            <div class="form-group ${messagesPerField.printIfExists('lastName','has-error')}">
                <div class="col-sm-2 col-md-2">
                    <label for="lastName" class="control-label">${msg("lastName")}</label> <span class="required">*</span>
                </div>

                <div class="col-sm-10 col-md-10">
                    <input type="text" class="form-control" id="lastName" name="lastName" value="${(account.lastName!'')}"/>
                </div>
            </div>

            <div class="form-group">
                <div class="col-sm-2 col-md-2">
                    <label for="user.attributes.phoneNumber" class="control-label">${msg("phoneNumber")}</label>
                </div>

                <div class="col-sm-10 col-md-10">
                    <input type="text" class="form-control" id="user.attributes.phoneNumber" name="user.attributes.phoneNumber" v-model="phoneNumber" />
                </div>
            </div>
            <div class="form-group">
                <div id="kc-form-buttons" class="col-md-offset-2 col-md-10 submit">
                    <div class="">
                        <#if url.referrerURI??><a href="${url.referrerURI}">${msg("backToApplication")?no_esc}/a></#if>
                        <button type="submit" class="${properties.kcButtonClass!} ${properties.kcButtonPrimaryClass!} ${properties.kcButtonLargeClass!}" name="submitAction" value="Save">${msg("doSave")}</button>
                        <button type="submit" class="${properties.kcButtonClass!} ${properties.kcButtonDefaultClass!} ${properties.kcButtonLargeClass!}" name="submitAction" value="Cancel">${msg("doCancel")}</button>
                    </div>
                </div>
            </div>

        </form>
    </div>
</@layout.mainLayout>