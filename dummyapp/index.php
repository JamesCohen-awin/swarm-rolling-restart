<?php

header("Content-Type: text/plain");

if ($_GET['sleep']) {
    sleep(30);
}

echo("Runnning version ". $_ENV['APPLICATION_VERSION']);
