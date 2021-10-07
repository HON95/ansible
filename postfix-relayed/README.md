# Ansible Role: Postfix (Relayed)

Sets up Postfix to forward mail to root to some alias through a relay service.

Test sending an email to verify the setup: `echo "Test from $(hostname) at time $(date)." | mail -s "Test" root`
