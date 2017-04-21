<?php

header("Content-Type: text/plain");

if ($_GET['sleep']) {

    $t = time();

    while(true) {
        if (time() - $t > 30) {
            break;
        }
    }

}

echo("Runnning version ". $_ENV['APPLICATION_VERSION']);
