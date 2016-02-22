echo "adding users and virtual host"
#add user
#rabbitmqctl add_user user_name user_pwd

#Set tags to user
#rabbitmqctl set_user_tags user_name administrator

#Add vhost
#rabbitmqctl add_vhost virtual_host

#Add permisions in vhost to user --> set_permissions [-p vhostpath] {user} {conf} {write} {read}
#rabbitmqctl set_permissions -p virtual_host user_name ".*" ".*" ".*"


echo "=> Done!"
touch /.config_set
