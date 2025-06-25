CREATE TABLE users (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),  -- Using extension-compatible function
    phone TEXT UNIQUE,
    email TEXT UNIQUE,
auth_provider TEXT NOT NULL CHECK (
    auth_provider = 'google'
    OR auth_provider = 'apple'
    OR auth_provider = 'phone'
)
    provider_uid TEXT,
    first_name TEXT,
    last_name TEXT,
    profile_picture TEXT,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ DEFAULT NOW()
);
