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
    .3 .4 .2 .5 0 .5 0 .9 .7 .2 .2 .1
);

my $series1 = Chart::Clicker::Data::Series->new(
    keys    => \@hours,
    values  => \@bw1,
);
my $series2 = Chart::Clicker::Data::Series->new(
    keys    => \@hours,
    values  => \@bw2,
);

# We'll create a dataset with our first two series in it...
my $ds = Chart::Clicker::Data::DataSet->new(
    series => [ $series1 ]
);

my $ds0 = Chart::Clicker::Data::DataSet->new(
    series => [ $series2 ]
);

# We'll put the third into it's own dataset so we can put it in a new context
my $series3 = Chart::Clicker::Data::Series->new(
    keys    => \@hours,
    values  => \@bw3,
);
my $ds1 = Chart::Clicker::Data::DataSet->new(
    series => [ $series3 ]
);

# Create a new context
my $other_context = Chart::Clicker::Context->new(
    name => 'other'
);
# Set it's labels...
$other_context->range_axis->label('Solor');
$other_context->range_axis->label_font->family('Hoefler Text');
$other_context->range_axis->tick_font->family('Hoefler Text');

$other_context->domain_axis->label('Amet');
$other_context->domain_axis->label_font->family('Hoefler Text');
$other_context->domain_axis->tick_font->family('Hoefler Text');

# Create a new context
my $other1_context = Chart::Clicker::Context->new(
    name => 'other1'
);
# Set it's labels...
$other1_context->range_axis->label('Solor2');
$other1_context->range_axis->label_font->family('Hoefler Text');
$other1_context->range_axis->tick_font->family('Hoefler Text');

$other1_context->domain_axis->label('Amet 2');
$other1_context->domain_axis->label_font->family('Hoefler Text');
$other1_context->domain_axis->tick_font->family('Hoefler Text');


$cc->legend->visible(0);

# Instruct the ds1 dataset to use the 'other' context.  DataSets default to
# the 'default' context.
$ds1->context('other');
$ds0->context('other1');
$cc->add_to_contexts($other_context);
$cc->add_to_contexts($other1_context);

# Pretty stuff
$cc->border->width(0);

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


# Add the datasets to the chart
$cc->add_to_datasets($ds);
$cc->add_to_datasets($ds1);
$cc->add_to_datasets($ds0);

$cc->background_color(
    Graphics::Color::RGB->new(red => .95, green => .94, blue => .92)
);
$cc->plot->grid->background_color->alpha(0);

# Set some labels on the default context
my $defctx = $cc->get_context('default');
$defctx->range_axis->label('Lorem');
$defctx->range_axis->label_font->family('Hoefler Text');
$defctx->range_axis->tick_font->family('Hoefler Text');
$defctx->domain_axis->label('Ipsum');
$defctx->domain_axis->tick_font->family('Hoefler Text');
$defctx->domain_axis->label_font->family('Hoefler Text');
$defctx->renderer->brush->width(2);

$cc->legend->font->family('Hoefler Text');

$cc->draw;

$cc->write('foo.pdf');
