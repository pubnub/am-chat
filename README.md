# PubNub Access Manager

PubNub Access Manager (PAM) extends PubNub’s existing security framework by providing a mechanism for application developers to create and enforce secure channels throughout the PubNub Real Time Network. PAM provides the ability to enforce security at three different levels and in any combination of the three: Application (TOP), Channel (Stream), Individual User by User.

## Where do I Start?

Getting started guide for PubNub Access Manager: The tutorial links below provides you with a walk-through of the API and how it works including sample code for JavaScript SDK.  Here are a list of resources for you to get started:

 - [PubNub Access Manager Getting Started Guide JavaScript SDK](http://www.pubnub.com/docs/javascript/tutorial/access-manager.html)
 - [PubNub Security Overview JavaScript SDK](http://www.pubnub.com/docs/javascript/overview/security.html)
 - [PubNub Access Manager Example Demo](http://pubnub.github.io/am-chat/)

Because the PubNub Access Manager is super simple, you'll want to see how it works by reading the code:

### PubNub Admin Mode with SECRET_KEY
Create an instance of PubNub with Admin Granting 
Capabilities by including the `secret_key`.
```javascript
var pubnub = PUBNUB.init({
    subscribe_key : 'my_subkey',
    publish_key   : 'my_pubkey',
    secret_key    : 'my_secretkey'
});
```

### Grant User Level Permission with Auth Key
Grant access to an `auth_key` which can be passed to a 
single user or group of users.
```javascript
pubnub.grant({
    channel  : 'privateChat',
    auth_key : 'abxyz12-auth-key-987tuv',
    read     : true,
    write    : true,
    ttl      : 60 // Minutes
});
```

### Grant Channel Level Permission
You simply exclude the `auth_key` paramater and this will 
globally grant access to all users.
```javascript
pubnub.grant({
    channel  : 'privateChat',
    read     : true,
    write    : true,
    ttl      : 60 // Minutes
});
```

### Revoke User Level Permission with Auth Key
Revoke access to an `auth_key`.
```javascript
pubnub.revoke({
    channel  : 'privateChat',
    auth_key : 'abxyz12-auth-key-987tuv'
});
```

### Revoke Channel Level Permission
You simply exclude the `auth_key` paramater and this will 
globally revoke access to all users.
```javascript
pubnub.grant({
    channel : 'privateChat'
});
```

## Secure Your Real-Time Apps
The fundamental operations related to Access Manager are granting and revoking access to keys and channels. In our chat example we will want to control who can join the chat room (subscribe) as well as be able to contribute to the chat (publish).


## What is PubNub?
Today’s users expect to interact in real-time. PubNub makes it easy for you to add real-time capabilities to your apps, without worrying about the infrastructure. Build apps that allow your users to engage in real-time across mobile, browser, desktop and server.

## What Can I Build With PubNub?
The PubNub Real-Time Network takes care of the connections, global infrastructure and key building blocks for real-time interactivity, so you can focus creating killer apps…

* Real-Time Collaboration
* Machine-to-Machine
* Real-Time Financial Streams
* Real-Time Location Tracking
* Call Triggering
* 2nd Screen Sync
* Live Dashboards
* Multi-Player Games
* Group Chat Rooms
* Thousands more…
