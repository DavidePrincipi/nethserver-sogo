FROM centos:7
ENV container docker
RUN (cd /lib/systemd/system/sysinit.target.wants/; for i in *; do [ $i == systemd-tmpfiles-setup.service ] || rm -f $i; done); \
    rm -f /lib/systemd/system/multi-user.target.wants/*; \
    rm -f /etc/systemd/system/*.wants/*; \
    rm -f /lib/systemd/system/local-fs.target.wants/*; \
    rm -f /lib/systemd/system/sockets.target.wants/*udev*; \
    rm -f /lib/systemd/system/sockets.target.wants/*initctl*; \
    rm -f /lib/systemd/system/basic.target.wants/*; \
    rm -f /lib/systemd/system/anaconda.target.wants/*; \
 yum localinstall -y \
   http://pkgs.repoforge.org/rpmforge-release/rpmforge-release-0.5.3-1.el7.rf.x86_64.rpm && \
 curl -L http://www.sogo.nu/files/downloads/SOGo/RHEL7/SOGo.repo > /etc/yum.repos.d/SOGo.repo && \
 yum -y --enablerepo=extras install epel-release && \
 yum -y --enablerepo=rpmforge-extras,sogo-rhel7 install sogo sogo-tool sope49-gdl1-mysql sogo-activesync mysql-libs && \
 yum clean all

VOLUME [ "/sys/fs/cgroup" ]
EXPOSE 20000
CMD /usr/sbin/sogod -WONoDetach YES -WOPidFile /var/run/sogo/sogo.pid -WOLogFile -

