import React from 'react';
import Grid from '@material-ui/core/Grid';
import Link from '@material-ui/core/Link';
import { makeStyles } from '@material-ui/core/styles';
import logoPath from '../images/e2rmini_logo.png';

const useStyles = makeStyles((theme) => ({
  grid: {
    minHeight: '64px',
  },
  img: {
    width: '160px',
  },
}));

export default function Logo() {
  const classes = useStyles();

  return (
    <Grid container alignItems="center" justify="center" className={classes.grid}>
      <Grid item>
        <Link href="/" color="inherit" variant="body2">
          <img src={logoPath} className={classes.img} />
        </Link>
      </Grid>
    </Grid>
  );
}
