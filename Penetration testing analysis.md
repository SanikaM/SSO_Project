# OWASP Single Sign-On Penetration Testing Analysis

### FIDO2 vulnerabilities –

The web application uses Fido2 which is a technique used to replace username and password. It is a standard used for authentication which uses public key cryptography. The identity of each user on a local device is figured out by the exchange of private and public keys. But FIDO2 uses the Diffie-Hellman algorithm for key exchange and this algorithm is unauthenticated. This gives rise to a vulnerability of MitM (Man in the Middle) and client impersonation. Attacker can exploit this vulnerability to get access to the authentication key which is further used in impersonation. 
Another vulnerability is the use of single pinToken at the startup in the FIDO2 authentication. If in the further communications, if any single session is compromised, then it can affect the other sessions. 

### SyslogPro vulnerabilities –

The application uses SyslogPro for its websocket Socket.io communication transport options. This is a NodeJs module which also comes with authentication and client server certificate authorization.  In the engine.io-client module for the versions below 1.6.9, there is a known vulnerability of the TLS module handling the rejectUnauthorized setting. This results in a default insecure configuration after getting the bad certificate. The vulnerability is mitigated by upgrading it to the version above 1.6.9. 
As we know the application uses Websockets, we can use the Zed Attack proxy (ZAP) to capture and analyse the requests and responses. Thus took can be used to replay the packets and can reveal sensitive information. 
Also, the application is susceptible for a Denial of Service (DOS) attack. This because it is possible to raise unlimited connections through Websockets.
Also there are input validations used in this application, which makes it vulnerable to injection attacks like SQL injection. 

### SAML vulnerability –

SAML uses XML and XML processing is vulnerable to a buffer overflow attack. This is because of the Document Type definitions which requires the various libraries to be included in the buffer which are included in the doc type definition. This could cause denial of service as all the resources are used up. SAML raider which is an extension tool of Burp Suite, can be used to find more SAML vulnerabilities. 

#### Mitigation –

One way to mitigate this vulnerability could be mitigated is by putting a limit to the payload size to less than 1 MB. 

### JWT vulnerabilities –

The JWT secret can be brute forced if the key used is smaller than the hash output. Tools like hashcat or john the ripper could be used to crack it. However, the key size is larger for this application and hence cannot be cracked.
The jwt parameters like jwk, jku and kid are used by attackers to perform JWT header injection attack. If the server is misconfigured, the server embeds jwk or jku or kid to embed its public key and uses this parameter instead. Then the attacker can generate his own private RSA key and embed the public key in these parameters. This exploitation can be tested on the Burp Suite. 
This application does not use any of these 3 parameters, so the attacker can embed then populate the value to exploit this vulnerability.
The kid parameter can also be used for an SQL injection attack, as it supports path traversal. 

#### Mitigation – 

Verification of the jwt header and maintaining a proper list of allowed hosts for the jku parameter. Avoiding path traversal and SQL injection using the kid parameter. 


