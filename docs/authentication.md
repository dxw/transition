# Authentication

Authentication for the dxw Transition Tool is provided via Auth0.

## In development

To set up authentication for your application:

Register a new tenant at [Auth0](https://manage.auth0.com/dashboard)

Create a new Regular Web Application in your tenant.

In the application settings, set the Allowed callback URLs to be
`http://localhost:3000/auth/auth0/callback`

Take note of the Client ID and Client Secret values in your new application. Enter these values in
`.env` as `AUTH0_CLIENT_ID` and `AUTH0_CLIENT_SECRET`

The value for `AUTH0_DOMAIN` in `.env` will also be in the application settings under Domain.

Create your user(s) in the Auth0 dashboard under `Users and Roles`. The users should have
the Connection Type of `Username-Password-Authentication`

After restarting your local instance, should be able to log in to
the application locally using the username/password you created for
your user in Auth0.

## Staging

TBA

## Production

TBA

