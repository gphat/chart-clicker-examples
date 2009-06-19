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
    1 2 3 4 5 6
);
my @bw1 = qw(
    10 30 50 120 230 400
);
my @bw2 = qw(
    0 2 9 12 15 18
);

my $series1 = Chart::Clicker::Data::Series->new(
    keys    => \@hours,
    values  => \@bw1,
    name => 'Feature Requests'
);
my $series2 = Chart::Clicker::Data::Series->new(
    keys    => \@hours,
    values  => \@bw2,
    name => 'Patches'
);

# We'll create a dataset with our first two series in it...
my $ds = Chart::Clicker::Data::DataSet->new(
    series => [ $series1, $series2 ]
);

# my $ds0 = Chart::Clicker::Data::DataSet->new(
#     series => [ $series2 ]
# );

# Create a new context
my $other_context = Chart::Clicker::Context->new(
    name => 'other'
);
#Set it's labels...
$other_context->range_axis->label('Patches');
$other_context->range_axis->label_font->family('Hoefler Text');
$other_context->range_axis->tick_font->family('Gentium');
$other_context->range_axis->format('%d');

# $other_context->domain_axis->label('Amet');
# $other_context->domain_axis->label_font->family('Hoefler Text');
# $other_context->domain_axis->tick_font->family('Hoefler Text');

$cc->legend->visible(1);

# Instruct the ds1 dataset to use the 'other' context.  DataSets default to
# the 'default' context.
# $ds0->context('other');
$cc->add_to_contexts($other_context);

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
$cc->color_allocator->colors([ $grey, $orange ]);

# Add the datasets to the chart
$cc->add_to_datasets($ds);
#$cc->add_to_datasets($ds0);

$cc->background_color(
    Graphics::Color::RGB->new(red => .95, green => .94, blue => .92)
);
$cc->plot->grid->background_color->alpha(0);

# Set some labels on the default context
my $defctx = $cc->get_context('default');

$other_context->domain_axis($defctx->domain_axis);

$defctx->range_axis->label('Requests');
$defctx->range_axis->label_font->family('Hoefler Text');
$defctx->range_axis->tick_font->family('Gentium');
$defctx->range_axis->format('%d');
$defctx->domain_axis->label('Month');
$defctx->domain_axis->tick_font->family('Gentium');
$defctx->domain_axis->label_font->family('Hoefler Text');
$defctx->domain_axis->format('%d');
$defctx->renderer->brush->width(2);

$cc->legend->font->family('Hoefler Text');

$cc->draw;

$cc->write('foo.pdf');
