class helloworld {
  file { '/tmp/testing.txt
    ensure  => present,
    content => "Hello World\n",
  }
}
