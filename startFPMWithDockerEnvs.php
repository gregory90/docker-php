#!/usr/bin/php
<?php
$confFile = '/etc/php5/fpm/pool.d/default.conf';

// Update the fpm configuration to make the docker environment variables available
// NOTE: ONLY in the CLI will $_SERVER have environment variables in it.
foreach($_SERVER as $envName=>$envVal ) {

        $fileText = file_get_contents($confFile);

        if($envVal == "") continue;

        `echo "env[$envName] = \"$envVal\"" >>$confFile`;
        echo "ADDED    $envName\n";
}

// Log something - Helps use know this script has run because out will be in the supervisord log
`supervisorctl start php5-fpm`;
echo "DONE\n";
