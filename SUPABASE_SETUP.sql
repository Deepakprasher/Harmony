-- ================================================================
-- The Harmony Within — Supabase Database Setup
-- Copy this entire file into Supabase > SQL Editor > Run
-- ================================================================

-- ── Daily Practice Log ────────────────────────────────────────────
CREATE TABLE IF NOT EXISTS practice_log (
  id            uuid DEFAULT gen_random_uuid() PRIMARY KEY,
  reader_id     text NOT NULL,
  date_logged   date DEFAULT CURRENT_DATE,
  dosha         text,
  practices     jsonb,   -- { meditation: true, yoga: true, etc }
  wellbeing     jsonb,   -- { clarity: 4, peace: 3, energy: 5, etc }
  klesha_active text,    -- which klesha was most active
  reflection    text,
  created_at    timestamptz DEFAULT now()
);

ALTER TABLE practice_log ENABLE ROW LEVEL SECURITY;
CREATE POLICY "Readers see own logs" ON practice_log
  FOR ALL USING (reader_id LIKE 'reader_%');

-- ── Dosha Assessment Results ──────────────────────────────────────
CREATE TABLE IF NOT EXISTS assessments (
  id            uuid DEFAULT gen_random_uuid() PRIMARY KEY,
  reader_id     text NOT NULL,
  dosha_scores  jsonb,   -- { vata: 6, pitta: 3, kapha: 1 }
  klesha_scores jsonb,   -- { avidya: 70, asmita: 45, etc }
  date_taken    date DEFAULT CURRENT_DATE
);

ALTER TABLE assessments ENABLE ROW LEVEL SECURITY;
CREATE POLICY "Readers see own assessments" ON assessments
  FOR ALL USING (reader_id LIKE 'reader_%');

-- ── Done ──────────────────────────────────────────────────────────
-- Your tables are ready. Return to the deployment guide.
