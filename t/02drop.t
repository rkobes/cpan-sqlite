#!/usr/bin/perl
use strict;
use warnings;
use Test::More;
use DBD::SQLite;
BEGIN {plan tests => 6};
my $db_name = 'cpandb.sql';

unlink($db_name) if (-e $db_name);

my $dbh = DBI->connect("DBI:SQLite:$db_name",
                       {RaiseError => 1, AutoCommit => 0})
  or die "Cannot connect to $db_name";
ok($dbh);
isa_ok($dbh, 'DBI::db');
my @tables = qw(mods auths chaps dists);
my $sql = qq{SELECT name FROM sqlite_master WHERE type='table' AND name=?};
my $sth = $dbh->prepare($sql);
for my $table(@tables) {
  $sth->execute($table);
  my $results = $sth->fetchrow_array;
  if ($results) {
    $dbh->do(qq{drop table $table});
  }
  pass("Drop $table");
}
$sth->finish;
undef $sth;
$dbh->disconnect;
