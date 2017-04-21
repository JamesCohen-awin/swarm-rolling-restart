<?php

header("Content-type: text/plain");

// avoid output buffering
ini_set("output_buffering", 0);
ob_implicit_flush();

system("ab -t30 -d -c3 http://dummyapp/");
