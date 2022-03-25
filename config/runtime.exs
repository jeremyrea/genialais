import Config

admin_email =
System.get_env("ADMIN_EMAIL") ||
    raise """
    environment variable ADMIN_EMAIL is missing.
    """

admin_password = 
System.get_env("ADMIN_PASSWORD") ||
    raise """
    environment variable ADMIN_PASSWORD is missing.
    """

config :genialais, adminEmail: admin_email
config :genialais, adminPassword: admin_password


