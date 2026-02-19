-- OpenClaw Install Service Leads Table
CREATE TABLE IF NOT EXISTS install_leads (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  name TEXT NOT NULL,
  email TEXT NOT NULL,
  phone TEXT,
  business TEXT NOT NULL,
  goals TEXT,
  source TEXT DEFAULT 'openclaw_landing',
  status TEXT DEFAULT 'new' CHECK (status IN ('new', 'contacted', 'qualified', 'closed', 'lost')),
  notes TEXT,
  submitted_at TIMESTAMPTZ DEFAULT NOW(),
  created_at TIMESTAMPTZ DEFAULT NOW()
);

-- Enable RLS
ALTER TABLE install_leads ENABLE ROW LEVEL SECURITY;

-- Allow anon inserts (for the landing page form)
CREATE POLICY "Allow anon insert on install_leads" ON install_leads
  FOR INSERT WITH CHECK (true);

-- Service role full access
CREATE POLICY "Service role full access on install_leads" ON install_leads
  FOR ALL USING (true);

-- Index for quick lookups
CREATE INDEX IF NOT EXISTS idx_install_leads_status ON install_leads(status);
CREATE INDEX IF NOT EXISTS idx_install_leads_created ON install_leads(created_at DESC);
