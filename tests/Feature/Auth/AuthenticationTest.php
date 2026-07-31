<?php

declare(strict_types=1);

use App\Models\User;
use Illuminate\Support\Facades\Hash;

it('registers a user and returns 201 with a token', function (): void {
    $response = $this->postJson('/api/v1/auth/register', [
        'name' => 'Jane Doe',
        'email' => 'jane@example.com',
        'password' => 'password123',
        'password_confirmation' => 'password123',
    ]);

    $response->assertCreated();
    $response->assertJsonStructure([
        'status',
        'message',
        'data' => [
            'user' => [
                'id',
                'name',
                'email',
                'email_verified_at',
                'created_at',
                'updated_at',
            ],
            'token',
        ],
    ]);
    $response->assertJsonPath('status', true);
    $response->assertJsonPath('data.user.name', 'Jane Doe');
    $response->assertJsonPath('data.user.email', 'jane@example.com');

    expect($response->json('data.token'))->toBeString()->not->toBeEmpty();
    expect(User::query()->where('email', 'jane@example.com')->exists())->toBeTrue();
});

it('returns 422 when registering with a duplicate email', function (): void {
    User::factory()->create(['email' => 'taken@example.com']);

    $response = $this->postJson('/api/v1/auth/register', [
        'name' => 'Jane Doe',
        'email' => 'taken@example.com',
        'password' => 'password123',
        'password_confirmation' => 'password123',
    ]);

    $response->assertUnprocessable();
    $response->assertJsonStructure([
        'status',
        'message',
        'errors' => [
            'email',
        ],
    ]);
    expect($response->json('status'))->toBeFalse();
    expect($response->json('errors.email'))->toBeArray()->not->toBeEmpty();
});

it('returns 422 when registering with a weak password', function (): void {
    $response = $this->postJson('/api/v1/auth/register', [
        'name' => 'Jane Doe',
        'email' => 'jane@example.com',
        'password' => 'short',
        'password_confirmation' => 'short',
    ]);

    $response->assertUnprocessable();
    $response->assertJsonStructure([
        'status',
        'message',
        'errors' => [
            'password',
        ],
    ]);
    expect($response->json('errors.password'))->toBeArray()->not->toBeEmpty();
});

it('returns 422 when registering with an unconfirmed password', function (): void {
    $response = $this->postJson('/api/v1/auth/register', [
        'name' => 'Jane Doe',
        'email' => 'jane@example.com',
        'password' => 'password123',
    ]);

    $response->assertUnprocessable();
    $response->assertJsonStructure([
        'status',
        'message',
        'errors' => [
            'password',
        ],
    ]);
    expect($response->json('errors.password'))->toBeArray()->not->toBeEmpty();
});

it('logs in and returns a token', function (): void {
    User::factory()->create([
        'email' => 'login@example.com',
        'password' => Hash::make('password123'),
    ]);

    $response = $this->postJson('/api/v1/auth/login', [
        'email' => 'login@example.com',
        'password' => 'password123',
    ]);

    $response->assertOk();
    $response->assertJsonStructure([
        'status',
        'message',
        'data' => [
            'user' => [
                'id',
                'name',
                'email',
                'email_verified_at',
                'created_at',
                'updated_at',
            ],
            'token',
        ],
    ]);
    $response->assertJsonPath('data.user.email', 'login@example.com');

    expect($response->json('data.token'))->toBeString()->not->toBeEmpty();
});

it('returns 422 when login credentials are wrong', function (): void {
    User::factory()->create([
        'email' => 'login@example.com',
        'password' => Hash::make('password123'),
    ]);

    $response = $this->postJson('/api/v1/auth/login', [
        'email' => 'login@example.com',
        'password' => 'wrong-password',
    ]);

    $response->assertUnprocessable();
    $response->assertJson([
        'status' => false,
        'message' => 'The provided credentials are incorrect.',
        'errors' => [
            'email' => [
                'The provided credentials are incorrect.',
            ],
        ],
    ]);
});

it('returns success on logout and revokes the current token', function (): void {
    $user = User::factory()->create([
        'email' => 'logout@example.com',
        'password' => Hash::make('password123'),
    ]);

    $loginResponse = $this->postJson('/api/v1/auth/login', [
        'email' => 'logout@example.com',
        'password' => 'password123',
    ]);

    $token = $loginResponse->json('data.token');

    $this->postJson('/api/v1/auth/logout', [], [
        'Authorization' => 'Bearer '.$token,
    ])->assertOk()
        ->assertJson([
            'status' => true,
            'message' => 'Logged out successfully',
            'data' => null,
        ]);

    expect($user->fresh()->tokens()->count())->toBe(0);

    $this->app['auth']->forgetGuards();

    $this->postJson('/api/v1/auth/logout', [], [
        'Authorization' => 'Bearer '.$token,
    ])->assertUnauthorized()
        ->assertJson([
            'status' => false,
            'message' => 'Unauthenticated.',
        ]);

    expect($user->tokens()->count())->toBe(0);
});

it('returns 401 for a protected route without a token', function (): void {
    $this->postJson('/api/v1/auth/logout')
        ->assertUnauthorized()
        ->assertJson([
            'status' => false,
            'message' => 'Unauthenticated.',
        ]);
});
