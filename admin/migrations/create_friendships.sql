-- ═══════════════════════════════════════════════════════════════
--  Friendships table — система друзей Synapse
--  Run this in the Supabase SQL editor
-- ═══════════════════════════════════════════════════════════════

CREATE TABLE IF NOT EXISTS public.friendships (
  id          UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  user_id     UUID NOT NULL REFERENCES public.users(id) ON DELETE CASCADE,
  friend_id   UUID NOT NULL REFERENCES public.users(id) ON DELETE CASCADE,
  status      TEXT NOT NULL DEFAULT 'pending'
                CHECK (status IN ('pending', 'accepted')),
  created_at  TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  UNIQUE (user_id, friend_id)
);

-- Index for fast lookups
CREATE INDEX IF NOT EXISTS idx_friendships_user_id   ON public.friendships(user_id);
CREATE INDEX IF NOT EXISTS idx_friendships_friend_id ON public.friendships(friend_id);
CREATE INDEX IF NOT EXISTS idx_friendships_status    ON public.friendships(status);

-- ── Row Level Security ──────────────────────────────────────────
ALTER TABLE public.friendships ENABLE ROW LEVEL SECURITY;

-- Users can read their own friendships (sent or received)
CREATE POLICY "Users can read own friendships"
  ON public.friendships FOR SELECT
  USING (auth.uid() = user_id OR auth.uid() = friend_id);

-- Users can insert friend requests from themselves
CREATE POLICY "Users can send friend requests"
  ON public.friendships FOR INSERT
  WITH CHECK (auth.uid() = user_id);

-- Users can update requests where they are the recipient (accept)
-- or where they are the sender (cancel)
CREATE POLICY "Users can update own friendships"
  ON public.friendships FOR UPDATE
  USING (auth.uid() = user_id OR auth.uid() = friend_id);

-- Users can delete their own friendships
CREATE POLICY "Users can delete own friendships"
  ON public.friendships FOR DELETE
  USING (auth.uid() = user_id OR auth.uid() = friend_id);

-- ── Allow name search in users table ──────────────────────────
-- If not already present, ensure users table has RLS select for
-- any authenticated user (needed for friend search by name).
-- Uncomment if not already configured:
-- CREATE POLICY "Authenticated users can search users"
--   ON public.users FOR SELECT
--   TO authenticated
--   USING (true);
