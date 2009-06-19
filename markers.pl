#!/usr/bin/perl
use strict;

use Chart::Clicker;
use Chart::Clicker::Context;
use Chart::Clicker::Data::DataSet;
use Chart::Clicker::Data::Marker;
use Chart::Clicker::Data::Series;
use Geometry::Primitive::Rectangle;
use Graphics::Color::RGB;

my $cc = Chart::Clicker->new(width => 500, height => 250, format => 'pdf');

my $series1 = Chart::Clicker::Data::Series->new(
    keys    => [qw(1 2 3 4 5 6 7 8 9 10 11 12)],
    values  => [qw(5.8 5.0 4.9 4.8 4.5 4.25 3.5 2.9 2.5 1.8 .9 .8)]
);

my $ds = Chart::Clicker::Data::DataSet->new(series => [ $series1 ]);

$cc->add_to_datasets($ds);
$cc->border->width(0);

$cc->background_color(
    Graphics::Color::RGB->new(red => .95, green => .94, blue => .92)
);
$cc->plot->grid->background_color->alpha(0);

my $orange = Graphics::Color::RGB->new(
    red => .88, green => .48, blue => .09, alpha => 1
);
$cc->color_allocator->colors([ $orange ]);

my $domain_range_marker = Chart::Clicker::Data::Marker->new(key => 4, key2 => 6);
$domain_range_marker->inside_color(
    Graphics::Color::RGB->new(
        red => .88, green => .48, blue => .09, alpha => .35
    )
);

my $domain_marker = Chart::Clicker::Data::Marker->new(key => 7);
$domain_marker->color($orange);

my $range_range_marker = Chart::Clicker::Data::Marker->new(value => 4, value2 => 5);
$range_range_marker->inside_color(
    Graphics::Color::RGB->new(red => 0, green => 0, blue => 0, alpha => .12)
);

my $range_marker = Chart::Clicker::Data::Marker->new(value => 2);
$range_marker->color(
    Graphics::Color::RGB->new(
        red => .88, green => .48, blue => .09, alpha => .5
    )
);
$range_marker->brush->width(5);
$range_marker->brush->dash_pattern([qw(15 15)]);

my $defctx = $cc->get_context('default');
$cc->plot->grid->visible(0);

$cc->legend->visible(0);
$defctx->range_axis->label('Lorem');
$defctx->range_axis->show_ticks(0);
$defctx->domain_axis->label('Ipsum');
# $defctx->domain_axis->tick_label_angle(0.785398163);
$defctx->range_axis->label_font->family('Hoefler Text');
$defctx->range_axis->tick_font->family('Gentium');
$defctx->domain_axis->tick_font->family('Gentium');
$defctx->domain_axis->label_font->family('Hoefler Text');


$defctx->add_marker($domain_range_marker);
$defctx->add_marker($range_range_marker);
$defctx->add_marker($range_marker);
$defctx->add_marker($domain_marker);

$cc->draw;
$cc->write('foo.pdf');
