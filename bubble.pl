#!/usr/bin/perl
use strict;

use Chart::Clicker;
use Chart::Clicker::Context;
use Chart::Clicker::Data::DataSet;
use Chart::Clicker::Data::Marker;
use Chart::Clicker::Data::Series::Size;
use Geometry::Primitive::Rectangle;
use Chart::Clicker::Renderer::Bubble;
use Graphics::Color::RGB;
use Geometry::Primitive::Circle;

my $cc = Chart::Clicker->new(width => 500, height => 250, format => 'pdf');

my @hours = qw(
    1 2 3 4 5 6 7 8 9 10 11 12
);
my @bw1 = qw(
    5.8 5.0 4.9 4.8 4.5 4.25 3.5 2.9 2.5 1.8 .9 .8
);
my @bw2 = qw(
    .7 1.1 1.7 2.5 3.0 4.5 5.0 4.9 4.7 4.8 4.2 4.4
);
my @bw3 = qw(
    .3 1.4 1.2 1.5 4.0 3.5 2.0 1.9 2.7 4.2 3.2 1.1
);

my $series1 = Chart::Clicker::Data::Series::Size->new(
    keys    => \@hours,
    values  => \@bw1,
    sizes    => [qw(2 5 9 1 8 9 2 1 3 8 3 1)]
);
my $series2 = Chart::Clicker::Data::Series::Size->new(
    keys    => \@hours,
    values  => \@bw2,
    sizes    => [qw(2 5 4 1 8 9 2 1 6 8 8 7)]
);

my $series3 = Chart::Clicker::Data::Series::Size->new(
    keys    => \@hours,
    values  => \@bw3,
    sizes    => [qw(2 5 3 1 8 9 2 1 1 4 2 5)]
);


$cc->border->width(0);
$cc->background_color(
    Graphics::Color::RGB->new(red => .95, green => .94, blue => .92)
);
my $grey = Graphics::Color::RGB->new(
    red => .36, green => .36, blue => .36, alpha => 1
);
my $moregrey = Graphics::Color::RGB->new(
    red => .71, green => .71, blue => .71, alpha => 1
);
my $orange = Graphics::Color::RGB->new(
    red => .88, green => .48, blue => .09, alpha => 1
);
$cc->color_allocator->colors([ $grey, $moregrey, $orange ]);

$cc->plot->grid->background_color->alpha(0);
my $ds = Chart::Clicker::Data::DataSet->new(series => [ $series1, $series2, $series3 ]);

$cc->add_to_datasets($ds);

my $defctx = $cc->get_context('default');

$defctx->range_axis->label('Lorem');
$defctx->domain_axis->label('Ipsum');
$defctx->range_axis->fudge_amount(.05);
$defctx->domain_axis->fudge_amount(.05);
$defctx->range_axis->label_font->family('Amaze');
$defctx->range_axis->tick_font->family('Amaze');
$defctx->domain_axis->tick_font->family('Amaze');
$defctx->domain_axis->label_font->family('Amaze');
$defctx->renderer(Chart::Clicker::Renderer::Bubble->new);

$cc->legend->visible(0);

$cc->draw;
$cc->write('foo.pdf');
