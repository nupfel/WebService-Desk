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
            cases => { path        => 'cases' },
            case  => { pre_id_path => 'cases', require_id => 1 },
            update_case =>
                { method => 'PUT', pre_id_path => 'cases', require_id => 1 },

            # customers
            customers       => { path        => 'customers' },
            customer        => { pre_id_path => 'customers', require_id => 1 },
            create_customer => { method      => 'POST', path => 'customers' },
            update_customer => {
                method      => 'PUT',
                pre_id_path => 'customers',
                require_id  => 1
            },
            create_customer_email => {
                method       => 'POST',
                pre_id_path  => 'customers',
                post_id_path => 'emails',
                require_id   => 1,
                mandatory    => ['email'],
            },
            update_customer_email => {
                method       => 'PUT',
                pre_id_path  => 'customers',
                post_id_path => 'emails/:id',
                require_id   => 1,
                mandatory    => ['email'],
            },
            create_customer_phone => {
                method       => 'POST',
                pre_id_path  => 'customers',
                post_id_path => 'phones',
                require_id   => 1,
                mandatory    => ['phone'],
            },
            update_customer_phone => {
                method       => 'PUT',
                pre_id_path  => 'customers',
                post_id_path => 'phones/:id',
                require_id   => 1,
                mandatory    => ['phone'],
            },

            interactions       => { path => 'interactions' },
            create_interaction => {
                method    => 'POST',
                path      => 'interactions',
                mandatory => ['interaction_subject'],
            },

            # users/groups
            groups => { path        => 'groups' },
            group  => { pre_id_path => 'groups', require_id => 1 },
            users  => { path        => 'users' },
            user   => { pre_id_path => 'users', require_id => 1 },

            # topics
            topics => { path        => 'topics' },
            topics => { pre_id_path => 'topics', require_id => 1 },
            create_topic =>
                { method => 'POST', path => 'topics', mandatory => ['name'], },
            update_topic =>
                { method => 'PUT', pre_id_path => 'topics', require_id => 1, },
            delete_topic => {
                method      => 'DELETE',
                pre_id_path => 'topics',
                require_id  => 1,
            },
            topic_articles => {
                pre_id_path  => 'topics',
                post_id_path => 'articles',
                require_id   => 1,
            },
            create_article => {
                method       => 'POST',
                pre_id_path  => 'topics',
                post_id_path => 'articles',
                require_id   => 1,
                mandatory    => ['subject'],
            },
            article        => { pre_id_path => 'articles', require_id => 1, },
            update_article => {
                method      => 'PUT',
                pre_id_path => 'articles',
                require_id  => 1,
            },
            delete_article => {
                method      => 'DELETE',
                pre_id_path => 'articles',
                require_id  => 1,
            },

            # macros
            macros => { path        => 'macros' },
            macro  => { pre_id_path => 'macros', require_id => 1 },
            create_macro =>
                { method => 'POST', path => 'macros', mandatory => ['name'], },
            update_macro =>
                { method => 'PUT', pre_id_path => 'macros', require_id => 1, },
            delete_macro => {
                method      => 'DELETE',
                pre_id_path => 'macros',
                require_id  => 1,
            },

            # macro actions
            macro_actions => {
                pre_id_path  => 'macros',
                post_id_path => 'actions',
                require_id   => 1,
            },
            macro_action => {
                pre_id_path  => 'macros',
                post_id_path => 'actions/:slug',
                require_id   => 1
            },
            update_macro_action => {
                method       => 'PUT',
                pre_id_path  => 'macros',
                post_id_path => 'actions/:action_type',
                require_id   => 1,
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

    $self->user_agent(__PACKAGE__ . ' ' . $VERSION);
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
