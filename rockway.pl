#!/usr/bin/perl
use strict;

use Chart::Clicker;
use Chart::Clicker::Context;
use Chart::Clicker::Data::DataSet;
use Chart::Clicker::Data::Marker;
use Chart::Clicker::Data::Series;
use Chart::Clicker::Renderer::Bar;
use Geometry::Primitive::Rectangle;
use Graphics::Color::RGB;
use Graphics::Primitive::Driver::CairoPango;

my $cc = Chart::Clicker->new(
    width => 500, height => 250, format => 'pdf',
    driver => Graphics::Primitive::Driver::CairoPango->new(format => 'pdf')
);

my @hours = qw(
    1 2 3 4 5
);
my @bw1 = qw(
    1 5 10 15 20
);

my $series1 = Chart::Clicker::Data::Series->new(
    keys    => \@hours,
    values  => \@bw1,
    name    => 'jrockway'
);

# We'll create a dataset with our first two series in it...
my $ds = Chart::Clicker::Data::DataSet->new(
    series => [ $series1 ]
);

# Create a new context
my $other_context = Chart::Clicker::Context->new(
    name => 'other'
);

my $defctx = $cc->get_context('default');

# Pretty stuff
$cc->border->width(0);
$cc->padding(10);

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

# Set some labels on the default context
my $defctx = $cc->get_context('default');
$defctx->range_axis->label('Amount of Love');
$defctx->range_axis->baseline(0);
$defctx->domain_axis->fudge_amount(.1);
$defctx->domain_axis->tick_values([qw(1 2 3 4 5)]);
$defctx->domain_axis->tick_labels(["Perl", "Lisp", "Java", "PHP", "Dongs\n<span size=\"x-small\">(not cocks)</span>"]);
$defctx->domain_axis->label('Thing');

# $defctx->domain_axis->tick_label_angle(0.785398163);
$defctx->range_axis->label_font->family('Hoefler Text');
$defctx->range_axis->show_ticks(0);
# $defctx->range_axis->hidden(1);
$defctx->domain_axis->fudge_amount(.15);
$defctx->domain_axis->tick_label_angle(1.0);
$defctx->range_axis->tick_font->family('Hoefler Text');
$defctx->domain_axis->tick_font->family('Hoefler Text');
$defctx->domain_axis->label_font->family('Hoefler Text');

# $cc->background_color(
    # Graphics::Color::RGB->new(red => .95, green => .94, blue => .92)
# );
$cc->plot->grid->background_color->alpha(0);
$cc->plot->grid->visible(0);

# Here's the magic: You can set a renderer for any context.  In this case
# we'll change the default to a Bar.  Voila!
$defctx->renderer(Chart::Clicker::Renderer::Bar->new(bar_padding => 32));

$cc->legend->font->family('Hoefler Text');

$cc->draw;
$cc->write('foo.pdf');
