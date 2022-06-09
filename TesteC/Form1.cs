namespace TesteC
{
    public partial class Form1 : Form
    {
        public Form1()
        {
            InitializeComponent();
        }

        private void Form1_Load(object sender, EventArgs e)
        {
            Trade trade = new Trade();
            List<Trade> portfolio = new List<Trade>();

            trade.Value = 2000000;
            trade.ClientSector = "Private";
            portfolio.Add(trade);

            trade = new Trade();
            trade.Value = 400000;
            trade.ClientSector = "Public";
            portfolio.Add(trade);

            trade = new Trade();
            trade.Value = 500000;
            trade.ClientSector = "Public";
            portfolio.Add(trade);

            trade = new Trade();
            trade.Value = 3000000;
            trade.ClientSector = "Public";
            portfolio.Add(trade);

            List<string> listResult = trade.GetCategories(portfolio);
            foreach(string result in listResult)
            {
                Console.WriteLine(result);
                listBox1.Items.Add(result);
            }
        }
    }
}