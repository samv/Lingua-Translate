#!/usr/bin/perl

use Test::More tests => 4;

use_ok("Lingua::Translate::Babelfish");

my $xl8r = Lingua::Translate::Babelfish->new(src => "en",
				             dest => "de");

ok(UNIVERSAL::isa($xl8r, "Lingua::Translate::Babelfish"),
   "Lingua::Translate::Babelfish->new()");

# test basic translation
my $german = $xl8r->translate("My hovercraft is full of eels.");

like($german, qr/mein.*Luftkissenfahrzeug.*(Aalen.*voll|voll.*Aalen)/i,
   "Lingua::Translate::Babelfish->translate [en -> de]");

# test to a bogus URL
eval {
    $xl8r->config(babelfish_uri => "http://badbadbad/translate?");
    $xl8r->translate("Something");
    fail("Translation with bad URI didn't die");
};

like($@, qr/Bad hostname/, "dies with bad URI");