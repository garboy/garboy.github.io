---
title:  "SAML, OAuth and SSO"
date:   2020-01-09 11:00:00 +0800
categories: tech
layout: post
---
## SAML Overview

Security Assertion Markup Language (SAML) is a standard for logging users into applications based on their sessions in another context. This single sign-on (SSO) login standard has significant advantages over logging in using a username/password:

- No need to type in credentials
- No need to remember and renew passwords
- No weak passwords

Most organizations already know the identity of users because they are logged in to their Active Directory domain or intranet. It makes sense to use this information to log users in to other applications, such as web-based applications, and one of the more elegant ways of doing this is by using SAML.

SAML is very powerful and flexible, but the specification can be quite a handful. OneLogin’s open-source SAML toolkits can help you integrate SAML in hours, instead of months. We’ve come up with a simple setup that will work for most applications.

### How SAML Works

SAML SSO works by transferring the user’s identity from one place (the identity provider) to another (the service provider). This is done through an exchange of digitally signed XML documents.

Consider the following scenario: A user is logged into a system that acts as an identity provider. The user wants to log in to a remote application, such as a support or accounting application (the service provider). The following happens:

The user accesses the remote application using a link on an intranet, a bookmark, or similar and the application loads.

The application identifies the user’s origin (by application subdomain, user IP address, or similar) and redirects the user back to the identity provider, asking for authentication. This is the authentication request.

The user either has an existing active browser session with the identity provider or establishes one by logging into the identity provider.

The identity provider builds the authentication response in the form of an XML-document containing the user’s username or email address, signs it using an X.509 certificate, and posts this information to the service provider.

The service provider, which already knows the identity provider and has a certificate fingerprint, retrieves the authentication response and validates it using the certificate fingerprint.

The identity of the user is established and the user is provided with app access.

### SAML SSO Flow

The diagram below illustrates the single sign-on flow for service provider-initiated SSO, i.e. when an application triggers SSO.

Identity provider-initiated SSO is similar and consists of only the bottom half of the flow.

---

1. [SO](https://stackoverflow.com/questions/29053277/cas-vs-saml-vs-oauth2)