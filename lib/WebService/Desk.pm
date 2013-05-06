package WebService::Desk;

use 5.010;
use Mouse;

# ABSTRACT: WebService::Desk - an interface to desk.com's RESTful Web API using Web::API

# VERSION

with 'Web::API';

=head1 SYNOPSIS

Please refer to the API documentation at L<http://dev.desk.com/docs/api>

    use WebService::Desk;
    
    my $desk = WebService::Desk->new(
        debug   => 1,
        api_key => '12345678-9abc-def0-1234-56789abcdef0',
    );
    
    my $response = $desk->create_interaction(
        subject      => "h4x0r",
        from_email   => "mail@example.com",
        text         => "what zee fug",
        track_opens  => 1,
        track_clicks => 1,
        to => [
            { email => 'mail@example.com' }
        ],
    );

=head1 SUBROUTINES/METHODS

=head2 ping

=cut

has 'commands' => (
    is      => 'rw',
    default => sub {
        {
            # cases
            cases       => { path   => 'cases' },
            case        => { path   => 'cases/:id' },
            update_case => { method => 'PUT', path => 'cases/:id' },

            # customers
            customers       => { path   => 'customers' },
            customer        => { path   => 'customers/:id' },
            create_customer => { method => 'POST', path => 'customers' },
            update_customer => { method => 'PUT', path => 'customers/:id' },
            create_customer_email => {
                method    => 'POST',
                path      => 'customers/:id/emails',
                mandatory => ['email'],
            },
            update_customer_email => {
                method    => 'PUT',
                path      => 'customers/:id/emails/:email_id',
                mandatory => ['email'],
            },
            create_customer_phone => {
                method    => 'POST',
                path      => 'customers/:id/phones',
                mandatory => ['phone'],
            },
            update_customer_phone => {
                method    => 'PUT',
                path      => 'customers/:id/phones/:phone_id',
                mandatory => ['phone'],
            },

            interactions       => { path => 'interactions' },
            create_interaction => {
                method    => 'POST',
                path      => 'interactions',
                mandatory => ['interaction_subject'],
            },

            # users/groups
            groups    => { path => 'groups' },
            get_group => { path => 'groups/:id' },
            users     => { path => 'users' },
            get_user  => { path => 'users/:id' },

            # topics
            topics => { path => 'topics' },
            topic  => { path => 'topics/:id' },
            create_topic =>
                { method => 'POST', path => 'topics', mandatory => ['name'], },
            update_topic => { method => 'PUT', path => 'topics/:id' },
            delete_topic => {
                method => 'DELETE',
                path   => 'topics/:id',
            },
            topic_articles => { path => 'topics/:id/articles', },
            create_article => {
                method    => 'POST',
                path      => 'topics/:id/articles',
                mandatory => ['subject'],
            },
            article        => { path => 'articles/:id' },
            update_article => {
                method => 'PUT',
                path   => 'articles/:id',
            },
            delete_article => {
                method => 'DELETE',
                path   => 'articles/:id',
            },

            # macros
            macros => { path => 'macros' },
            macro  => { path => 'macros/:id' },
            create_macro =>
                { method => 'POST', path => 'macros', mandatory => ['name'], },
            update_macro => { method => 'PUT', path => 'macros/:id' },
            delete_macro => {
                method => 'DELETE',
                path   => 'macros/:id',
            },

            # macro actions
            macro_actions       => { path => 'macros/:id/actions', },
            macro_action        => { path => 'macros/:id/actions/:slug', },
            update_macro_action => {
                method => 'PUT',
                path   => 'macros/:id/actions/:action_type',
            },
        };
    },
);

=head1 INTERNALS

=cut

sub commands {
    my ($self) = @_;
    return $self->commands;
}

=head2 BUILD

basic configuration for the client API happens usually in the BUILD method when using Web::API

=cut

sub BUILD {
    my ($self) = @_;

    $self->user_agent(__PACKAGE__ . ' ' . $WebService::Desk::VERSION);
    $self->content_type('application/json');
    $self->extension('json');
    $self->base_url('https://' . $self->user . '.desk.com/api/v1');
    $self->auth_type('oauth_params');

    return $self;
}

=head1 BUGS

Please report any bugs or feature requests on GitHub's issue tracker L<https://github.com/nupfel/WebService-Desk/issues>.


=head1 SUPPORT

You can find documentation for this module with the perldoc command.

    perldoc WebService::Desk


You can also look for information at:

=over 4

=item * GitHub repository

L<https://github.com/nupfel/WebService-Desk>

=item * MetaCPAN

L<https://metacpan.org/module/WebService::Desk>

=item * AnnoCPAN: Annotated CPAN documentation

L<http://annocpan.org/dist/WebService::Desk>

=item * CPAN Ratings

L<http://cpanratings.perl.org/d/WebService::Desk>

=back

=cut

1;    # End of WebService::Desk
