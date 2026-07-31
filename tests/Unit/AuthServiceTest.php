<?php

declare(strict_types=1);

use App\Models\User;
use App\Repositories\Contracts\UserRepositoryInterface;
use App\Services\AuthService;
use Illuminate\Support\Facades\Hash;
use Illuminate\Validation\ValidationException;
use Laravel\Sanctum\NewAccessToken;
use Laravel\Sanctum\PersonalAccessToken;

beforeEach(function (): void {
    $this->repository = Mockery::mock(UserRepositoryInterface::class);
    $this->service = new AuthService($this->repository);
});

afterEach(function (): void {
    Mockery::close();
});

function userWithToken(string $plainTextToken = 'test-token'): User
{
    $user = Mockery::mock(User::class)->makePartial();
    $user->shouldReceive('createToken')
        ->once()
        ->with('auth')
        ->andReturn(new NewAccessToken(
            Mockery::mock(PersonalAccessToken::class),
            $plainTextToken,
        ));

    return $user;
}

it('delegates register to the repository and returns a token', function (): void {
    $attributes = [
        'name' => 'Jane Doe',
        'email' => 'jane@example.com',
        'password' => 'password123',
    ];
    $user = userWithToken('registered-token');

    $this->repository
        ->shouldReceive('create')
        ->once()
        ->with([
            'name' => 'Jane Doe',
            'email' => 'jane@example.com',
            'password' => 'password123',
        ])
        ->andReturn($user);

    $result = $this->service->register($attributes);

    expect($result['user'])->toBe($user);
    expect($result['token'])->toBe('registered-token');
});

it('delegates login lookup to the repository and returns a token', function (): void {
    $user = userWithToken('login-token');
    $user->forceFill([
        'id' => 1,
        'email' => 'login@example.com',
        'password' => Hash::make('password123'),
    ]);

    $this->repository
        ->shouldReceive('findByEmail')
        ->once()
        ->with('login@example.com')
        ->andReturn($user);

    $result = $this->service->login('login@example.com', 'password123');

    expect($result['user'])->toBe($user);
    expect($result['token'])->toBe('login-token');
});

it('throws when login credentials are incorrect', function (): void {
    $this->repository
        ->shouldReceive('findByEmail')
        ->once()
        ->with('missing@example.com')
        ->andReturn(null);

    expect(fn () => $this->service->login('missing@example.com', 'wrong-password'))
        ->toThrow(ValidationException::class);
});

it('throws when the password does not match', function (): void {
    $user = (new User)->forceFill([
        'email' => 'login@example.com',
        'password' => Hash::make('password123'),
    ]);

    $this->repository
        ->shouldReceive('findByEmail')
        ->once()
        ->with('login@example.com')
        ->andReturn($user);

    expect(fn () => $this->service->login('login@example.com', 'wrong-password'))
        ->toThrow(ValidationException::class);
});
