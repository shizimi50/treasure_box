import { createTheme } from '@material-ui/core/styles';
import { grey } from '@material-ui/core/colors';

// Font
const fontFamily = [
  'Noto Sans JP',
  'メイリオ',
  'ＭＳ Ｐゴシック',
  'sans-serif',
].join(',');

const theme = createTheme({
  typography: {
    fontFamily: fontFamily,  // フォント
  },
});

export default theme;
