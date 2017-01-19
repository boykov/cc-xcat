#!/bin/bash

sshxcat=(sshpass -p cluster ssh -o "GSSAPIAuthentication no" -o "UserKnownHostsFile /dev/null" -o StrictHostKeyChecking=no -o "VerifyHostKeyDNS no" -q)

function lsxcatd() {
    	"${sshxcat[@]}" root@$1 /opt/xcat/bin/lsxcatd -a
}

function lsxcatd_out() {
cat <<EOF
Version 2.12.2 (git commit e4a7359d31008d81c4c57e0857d5f09009a3269c, built Thu Aug 18 06:46:17 EDT 2016)
This is a Management Node
dbengine=SQLite
EOF
}

function tabdump() {
    	"${sshxcat[@]}" root@$1 /opt/xcat/sbin/tabdump site
}

function tabdump_out() {
cat <<EOF
#key,value,comments,disable
"blademaxp","64",,
"fsptimeout","0",,
"installdir","/install",,
"ipmimaxp","64",,
"ipmiretries","3",,
"ipmitimeout","2",,
"consoleondemand","no",,
"master","172.17.0.13",,
"forwarders","8.8.8.8,8.8.4.4",,
"nameservers","172.17.0.13",,
"maxssh","8",,
"ppcmaxp","64",,
"ppcretry","3",,
"ppctimeout","0",,
"powerinterval","0",,
"syspowerinterval","0",,
"sharedtftp","1",,
"SNsyncfiledir","/var/xcat/syncfiles",,
"nodesyncfiledir","/var/xcat/node/syncfiles",,
"tftpdir","/tftpboot",,
"xcatdport","3001",,
"xcatiport","3002",,
"xcatconfdir","/etc/xcat",,
"timezone","UTC",,
"useNmapfromMN","no",,
"enableASMI","no",,
"db2installloc","/mntdb2",,
"databaseloc","/var/lib",,
"sshbetweennodes","ALLGROUPS",,
"dnshandler","ddns",,
"vsftp","n",,
"cleanupxcatpost","no",,
"dhcplease","43200",,
"auditnosyslog","0",,
"xcatsslversion","TLSv1",,
"auditskipcmds","ALL",,
"domain","cluster",,
EOF
}

function gettab() {
    	"${sshxcat[@]}" root@$1 /opt/xcat/bin/gettab -H key=domain site.value
}

function gettab_out() {
cat <<EOF
site.value: cluster
EOF
}


function lsdefDomain() {
    	"${sshxcat[@]}" root@$1 /opt/xcat/bin/lsdef -t site -l -i domain
}

function lsdefDomain_out() {
cat <<EOF
Object name: clustersite
    domain=cluster
EOF
}

function lsdefMaster() {
    	"${sshxcat[@]}" root@$1 /opt/xcat/bin/lsdef -t site -l -i master
}

function lsdefMaster_out() {
cat <<EOF
Object name: clustersite
    master=172.17.0.13
EOF
}

function openssl() {
    	"${sshxcat[@]}" root@$1 openssl x509 -text -in /etc/xcat/cert/server-cert.pem -noout |grep Sub
}

function openssl_out() {
cat <<EOF
        Subject: CN=11687faae091
        Subject Public Key Info:
            X509v3 Subject Alternative Name: 
EOF
}

function gettabDHCP() {
    	"${sshxcat[@]}" root@$1 /opt/xcat/bin/gettab key=dhcpinterfaces site.value
}

function gettabDHCP_out() {
cat <<EOF
EOF
}

function gettabNetname() {
    	"${sshxcat[@]}" root@$1 /opt/xcat/bin/gettab netname="172_17_0_0-255_255_0_0" networks.mgtifname
}

function gettabNetname_out() {
cat <<EOF
eth0
EOF
}

function tabdumpNetworks() {
    	"${sshxcat[@]}" root@$1 /opt/xcat/sbin/tabdump networks
}

function tabdumpNetworks_out() {
cat <<EOF
#netname,net,mask,mgtifname,gateway,dhcpserver,tftpserver,nameservers,ntpservers,logservers,dynamicrange,staticrange,staticrangeincrement,nodehostname,ddnsdomain,vlanid,domain,comments,disable
"172_17_0_0-255_255_0_0","172.17.0.0","255.255.0.0","eth0","172.17.0.1",,"172.17.0.13",,,,,,,,,,,,
EOF
}

function tabdumpNoderes() {
    	"${sshxcat[@]}" root@$1 /opt/xcat/sbin/tabdump noderes
}

function tabdumpNoderes_out() {
cat <<EOF
#node,servicenode,netboot,tftpserver,tftpdir,nfsserver,monserver,nfsdir,installnic,primarynic,discoverynics,cmdinterface,xcatmaster,current_osimage,next_osimage,nimserver,routenames,nameservers,proxydhcp,syslog,comments,disable
EOF
}

function tabdumpNodetype() {
    	"${sshxcat[@]}" root@$1 /opt/xcat/sbin/tabdump nodetype
}

function tabdumpNodetype_out() {
cat <<EOF
#node,os,arch,profile,provmethod,supportedarchs,nodetype,comments,disable
EOF
}

function tabdumpPostscritps() {
    	"${sshxcat[@]}" root@$1 /opt/xcat/sbin/tabdump postscripts
}

function tabdumpPostscritps_out() {
cat <<EOF
#node,postscripts,postbootscripts,comments,disable
"xcatdefaults","syslog,remoteshell,syncfiles","otherpkgs",,
"service","servicenode",,,
EOF
}
