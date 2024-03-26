const amplifyconfig = ''' {
  "UserAgent": "aws-amplify-cli/2.0",
  "Version": "1.0",

  "api": {
      "plugins": {
          "awsAPIPlugin": {
              "preeoh": {
                  "endpointType": "REST",                    
                  "endpoint": "https://preeoh-api-34d248de0ab6.herokuapp.com",
                  "region": "eu-north-1",
                  "authorizationType": "AMAZON_COGNITO_USER_POOLS"
              }
          }
      }
  },    

  "auth": {
    "plugins": {
      "awsCognitoAuthPlugin": {
        "IdentityManager": {
          "Default": {}
        },
        "CredentialsProvider": {
          "CognitoIdentity": {
            "Default": {
              "PoolId": "eu-north-1:c7368751-4161-4e30-8307-f18f6b5bced7",
              "Region": "eu-north-1"
            }
          }
        },
        "CognitoUserPool": {
          "Default": {
            "PoolId": "eu-north-1_KbFsPmins",
            "AppClientId": "2ls1u20d686ams5t4qdn42ilkb",
            "Region": "eu-north-1"
          }
        },
        "Auth": {
              "Default": {
                  "OAuth": {
                      "WebDomain": "preeoh-dev.auth.eu-north-1.amazoncognito.com",
                      "AppClientId": "2ls1u20d686ams5t4qdn42ilkb",
                      "SignInRedirectURI": "http://localhost:51078/",
                      "SignOutRedirectURI": "http://localhost:51078/",
                      "Scopes": [
                          "phone",
                          "email",
                          "openid",
                          "profile",
                          "aws.cognito.signin.user.admin"
                      ]
                  },
                  "authenticationFlowType": "USER_SRP_AUTH",
                  "socialProviders": [
                      "GOOGLE"
                  ],
                  "usernameAttributes": [
                      "EMAIL"
                  ],
                  "signupAttributes": [
                      "EMAIL"
                  ],
                  "passwordProtectionSettings": {
                      "passwordPolicyMinLength": 8,
                      "passwordPolicyCharacters": []
                  },
                  "mfaConfiguration": "OFF",
                  "mfaTypes": [
                      "SMS"
                  ],
                  "verificationMechanisms": [
                      "EMAIL"
                  ]
              }
          }
      }
    }
  }
}''';
