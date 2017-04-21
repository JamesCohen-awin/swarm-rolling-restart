<?php

header("Content-Type: text/plain");

echo file_get_contents("http://dummyapp/?sleep=1");
