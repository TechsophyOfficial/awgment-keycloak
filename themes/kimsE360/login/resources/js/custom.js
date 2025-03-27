console.log('inside custom theme file')
var BUCKET_LINK = "https://res.cloudinary.com/dyjgy2ple/image/upload/v1628487222/"
var BUCKET_LINK2 = "https://res.cloudinary.com/dyjgy2ple/image/upload/v1628487227/"

var BG_IMAGE = "/bg.png"
var LOGO_IMAGE = "/logo.png"
var LOGO_SIZE = "110px"

$( document ).ready(function() {
    function getRealm() { // GET the realm name from current url
        var realm = ''
        currLoc = $(location).attr('href');
        var urlArray = currLoc.split('/');
        if(urlArray.length > 0) {
            realm = urlArray[5]
        } 
        return realm
    }

    //Get the background image link for login screen
   function getBgLink(realm){
        var link = BUCKET_LINK + realm + BG_IMAGE
        return link
    }

    //get logo link for login screen
   function getLogoLink(realm){
        var link = BUCKET_LINK2 + realm + LOGO_IMAGE
        return link
    }

    //create image tag and insert inside kc-logo-text
    function setLogoImage(logoLink) {
        if(logoLink) {
            var img = document.createElement('img');
            img.src = logoLink
            $(img).css('height' , LOGO_SIZE)
            var wrapper =$('#kc-header-wrapper')
            wrapper.empty() 
            wrapper.append(img)
        }
      
    }

    var realm = getRealm()
    // var bgLink = getBgLink(realm)
    // var logoLink = getLogoLink(realm)

    document.body.style.backgroundImage = "url(" + bgLink + ")";
    // setLogoImage(logoLink)
});
