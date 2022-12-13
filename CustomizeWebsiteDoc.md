# Integrating custom website with SSO

## Project Overview
My project was to analyse and contribute towards the open source application 'OWASP SSO'. This project provides a Single Sign-On provision which individual organizations can incorporate into their website for secure and phishing-proof authentication. This allows individual organizations to safe guard and have full control over their own data and not trust it upon a third party SSO provider. This also allows applications to embed the code and provide authentication in different stages.
The application uses various security techniques as FIDO2, user certificate integrated with the company certificate. Also the application uses an anti-phishing email confirmation during the authentication.
  
## Project Overview

### Initial steps
  
1. Install node.js 
2. Perform a git clone of the repo to run it on your local machine by using the command : git clone \url{https://github.com/OWASP/SSO_Project.git}.
 
 ### Backend setup
 
 1. Use the command cd SSOProject/js-backend to go to the backend directory.
 2. Run npm install to install the dependencies.
 3. Modify the env file, where you need to write the email address of the administrator and also enter the Maria DB credentials. 
 4. Install bash shell and Git. Add the bash.exe file to the PATH environment variable.
 5. Navigate to the path SSO Project/js-backend/scripts/ and run the command bash setup.bash "OWASP SSO". This way you can generate the certificates.
 6. Navigate to SSO Project/js-backend an run the command npm run server. This starts running on https://localhost:3000.
 7. You will get a certificate warning, after accessing the page, accept this warning.
  
 ### Frontend setup
  1. In a new console, navigate to the folder SSO Project/vue-ui
  2. Run the command npm install to install all the dependencies.
  3. Run the command npm run serve.
  4. The ui for the application opens at https://localhost:8080 in the browser.

### Docker Setup

The below commands are used for used for Docker setup -
1. npm run docker:dev - To start the development environment
2. npm run docker:prod - To start the production environment
3. npm run docker:cleanup - To clean up all containers

## Integrating with the website

To integrate the website with the OWASP SSO, we need to modify the .env file and websites.json file like below -

Contents of .env file -

DOMAIN=
STAGING=true
EMAIL=


```javascript
{
	"default": { // Default behavior of the website, if no SSO flow is used
		name: "OWASP SSO", // Name of default page, internal identifier
		"branding": { // Allows branding the login page
			"backgroundColor": "#f7f9fb", // Page background color
			"fontColor": "#888", // Color of the text below the login box
			"legalName": "OWASP Foundation", // Legal name displayed below the login box
			"privacyPolicy": "https://owasp.org/www-policy/operational/privacy", // Link to privacy policy, mandatory
			"imprint": "https://owasp.org/contact/", // Link to legal imprint, optional
			"logo": "https://owasp.org/assets/images/logo.png" // Link to logo
		},
		"terms": "https://owasp.org/www-policy/operational/general-disclaimer", // Link to terms & conditions, Optional
		// If you want to use multi-language terms, you can fill terms with an object like this: {"en": "english-link", "de": "german-link"}
		"syslog": { // Configure a syslog server that will receive audit logs in CEF format, optional
			"target": "default-siem", // IP or hostname
			"protocol": "tcp" // Protocol
			// Check out all parameters at https://cyamato.github.io/SyslogPro/module-SyslogPro-Syslog.html
		}
	},
	"1": { // ID of the website
		"jwt": "hello-world", // JWT secret for authentication flow
		"signedRequestsOnly": false, // If set to true, only signed login requests are allowed
		"name": "E Corp", // Short name of the company
		"redirect": "https://postman-echo.com/post", // URL to redirect to
		"samlAllowedConsumers": [ // List of allowed AssertionConsumerServiceURL values
			"https://postman-echo.com/post?saml"
		],
		"branding": { // Allows branding the login page
			"backgroundColor": "#fff", // Page background color
			"fontColor": "#254799", // Color of the text below the login box
			"legalName": "E Corp", // Legal name displayed below the login box
			"privacyPolicy": "https://www.nbcuniversal.com/privacy", // Link to privacy policy, mandatory
			"imprint": "https://www.e-corp-usa.com/about.html", // Link to legal imprint, optional
			"logo": "https://www.e-corp-usa.com/images/e-corp-logo-blue.png" // Link to logo
		},
		"certificates": [{ // Allow external certificate authorities, optional
			"authorities": ["e-corp.ca.pem"], // List of CA files in js-backend/keys/ca folder to be used for this webhook
			"webhook": { // Webhook settings. If not set, matching with a custom CA passes authentication
				"url": "https://postman-echo.com/post", // URL for the server to contact for verification
				"successContains": "94:0B:DE:AD:BB:80:10:BD:17:C1:48:B4:5A:B2:66:3C:B5:75:DE:7B:89:37:65:D3:60:FF:B0:09:26:27:B2:91", // If the webhook return contains this text, pass the check
				"successRegex": "/test/" // If the webhook return matches this regex, pass the check
			}
		}]
	}
}
```
