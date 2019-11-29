# when see the permission issue use this command

    sysctl vm.overcommit_memory=1
    echo never > /sys/kernel/mm/transparent_hugepage/enabled
    update-permissions

# import repository from other 

    import repository 
    use web create repository
    git push --mirror ssh://git@hostname:33/user/repository.git
